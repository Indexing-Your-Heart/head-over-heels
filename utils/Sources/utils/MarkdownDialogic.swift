//
//  MarkdownDialogic.swift
//  Created by Marquis Kurt on 10/1/22.
//  This file is part of Indexing Your Heart.
//
//  Indexing Your Heart is non-violent software: you can use, redistribute, and/or modify it under the terms of the
//  CNPLv7+ as found in the LICENSE file in the source code root directory or at
//  <https://git.pixie.town/thufie/npl-builder>.
//
//  Indexing Your Heart comes with ABSOLUTELY NO WARRANTY, to the extent permitted by applicable law. See the CNPL for
//  details.


import Foundation
import Markdown

public class MarkdownDialogicParser {
    public let srcText: String

    public init(from source: String) {
        srcText = source
    }

    public func parse() -> [Dialogable] {
        let mdDoc = Document(parsing: srcText)
        if mdDoc.isEmpty { return [Dialogable]() }
        var parts = [Dialogable]()

        for child in mdDoc.children {
            if let paragraph = child as? Paragraph {
                parts.append(contentsOf: parseParagraph(paragraph))
            }
            else if let quote = child as? BlockQuote {
                parts.append(parseBlockQuote(quote))
            }
            else if let question = child as? UnorderedList {
                if question.childCount != 1 { continue }
                parts.append(parseQuestion(question.child(at: 0)! as! ListItem))
            }
        }

        return parts
    }

    /// Parses a block quote as a comment.
    private func parseBlockQuote(_ blockQuote: BlockQuote) -> Comment {
        var note = ""
        for child in blockQuote.children where child is Paragraph {
            for pChild in child.children where pChild is Text {
                note += (pChild as? Text)?.plainText ?? ""
            }
        }
        return Comment(note: note)
    }

    /// Parses a list item as a choice.
    private func parseChoice(_ choice: ListItem) -> Choice {
        let choiceName = choice.child(through: 0, 0) as! Text
        let choiceResults = choice.child(through: 1) as! UnorderedList
        var dialogues = [Dialogable]()

        for dialogue in choiceResults.children {
            if let dList = dialogue as? ListItem {
                for children in dList.children where children is Paragraph {
                    dialogues.append(contentsOf: parseParagraph(children as! Paragraph))
                }
            }
        }

        return Choice(choice: choiceName.plainText, dialogue: dialogues)
    }

    /// Parses a paragraph, extracting narration and dialogue elements as necessary.
    private func parseParagraph(_ paragraph: Paragraph) -> [Dialogable] {
        // If there are no elements in the paragraph, return an empty list.
        if paragraph.isEmpty { return [Dialogable]() }

        // Create a place to store dialogue parts.
        var dialogues = [Dialogable]()

        // Create a regex that will look for the format `Name: "Speech."`. This will, in turn, seek out dialogue lines
        // from a regular line of text.
        let diaRegex = #"([A-Za-z]+):\s*[“"]([\w\.!\?\s,;'…]+)+[”"](\s+)?"#

        // Loop through all of the children.
        for child in paragraph.children {
            // If the child is a Text element, start looking for lines of text to parse.
            if let line = child as? Text {
                
                // If the text is narration (i.e., doesn't match the text, just insert the plain text.
                if line.plainText.range(of: diaRegex, options: [.regularExpression]) == nil {
                    dialogues.append(
                        Narration(what: line.plainText)
                    )
                }

                // Otherwise, treat it as dialogue and create a dialogue element.
                else {
                    let splitContents = line.plainText.components(separatedBy: ": ")
                    if splitContents.count != 2 { continue }
                    dialogues.append(
                        Dialogue(
                            who: splitContents.first!,
                            what: splitContents.last!
                        )
                    )
                }
            }
        }
        return dialogues
    }

    /// Parses a list item as a question
    private func parseQuestion(_ question: ListItem) -> Question {
        let questionNameField = question.child(through: 0, 0) as! Text
        let choiceList = question.child(at: 1) as! UnorderedList
        let ques = questionNameField.plainText == "(Choice)" ? "" : questionNameField.plainText
        var choices = [Choice]()

        for choice in choiceList.children {
            if let choiceLI = choice as? ListItem {
                choices.append(parseChoice(choiceLI))
            }
        }

        return Question(question: ques, choices: choices)
    }
}
