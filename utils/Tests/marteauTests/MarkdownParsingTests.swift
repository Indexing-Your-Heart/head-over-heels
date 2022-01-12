//
//  MarkdownParsing.swift
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
import marteau
import XCTest

enum TestError: Error {
    case castReturnedNil
}

/// A test case that handles the Markdown to Dialogic parser.
final class MarkdownParsingTests: XCTestCase {

    /// Test that the Markdown to Dialogic parser can successfully construct a narration block.
    func testMarkdownNarration() throws {
        let example = "I slowly walk to the door."
        let parsedData = MarkdownDialogicParser(from: example).parse().first
        XCTAssertTrue(parsedData is Narration)
        XCTAssertEqual((parsedData as! Narration).what, example)
    }

    /// Test that the Markdown to Dialogic parser can successfuly construct a dialogue block.
    func testMarkdownDialogue() throws {
        let example = """
        Chelsea: "Can I have a hug?"
        John: "Uh, sure!"
        """

        let parsedData = MarkdownDialogicParser(from: example).parse()
        for child in parsedData {
            XCTAssertTrue(child is Dialogue)
        }
    }

    /// Test that the Markdown to Dialogic parser can successfully construct a comment block.
    func testMarkdownComment() throws {
        let example = "> This is a test."
        let parsedData = MarkdownDialogicParser(from: example).parse().first
        XCTAssertTrue(parsedData is Comment)
        XCTAssertEqual((parsedData as! Comment).note, "This is a test.")
    }

    /// Test that the Markdown to Dialogic parser can successfully construct a question block.
    func testMarkdownChoiceList() throws {
        let example = """
        - Where should I go?
            - "Left"
                - I decide to go left.
            - "Right"
                - I decide to go right.
        """

        let parsedData = MarkdownDialogicParser(from: example).parse().first
        XCTAssertTrue(parsedData is Question)

        guard let question = parsedData as? Question else {
            throw TestError.castReturnedNil
        }


        XCTAssertEqual(question.question, "Where should I go?")
        XCTAssertEqual(question.choices.count, 2)
        for choice in question.choices {
            XCTAssertFalse(choice.choice == "")
            XCTAssertTrue(choice.dialogue.count == 1)
            for line in choice.dialogue where line is Speakable {
                XCTAssertEqual((line as! Speakable).who, "")
            }
        }
    }

    /// Test that the Markdown to Dialogic parser can successfuly parse a full Markdown string.
    func testMarkdownParses() throws {
        let testExample = """
        It's another rainy day. I'm not sure I can handle it much longer.

        John: "Man, I really hate this rain. It never stops!"
        Chelsea: "Relax! It'll be sunny tomorrow."

        - What should I tell her?
            - "No, it's not."
                - I sulk a little.
                - Chelsea: "Sorry, I just wanted to make you happy..."
            - "Maybe..."
                - Chelsea: "Maybe we can work on a puzzle together or something!"

        > This is the end of the dialogue.
        """

        let parsedData = MarkdownDialogicParser(from: testExample).parse()
        XCTAssertEqual(parsedData.count, 5)
    }

    /// Test that the Markdown to Dialogic parser can successfully compile to a JSON string and write to a JSON file.
    func testMarkdownCompiles() throws {
        let testExample = """
        It's another rainy day. I'm not sure I can handle it much longer.

        John: "Man, I really hate this rain. It never stops!"
        Chelsea: "Relax! It'll be sunny tomorrow."

        - What should I tell her?
            - "No, it's not."
                - I sulk a little.
                - Chelsea: "Sorry, I just wanted to make you happy..."
            - "Maybe..."
                - Chelsea: "Maybe we can work on a puzzle together or something!"

        > This is the end of the dialogue.
        """

        let parsedData = MarkdownDialogicParser(from: testExample).compileToString()
        print("Resulting JSON:\n" + parsedData)

        XCTAssertNotEqual(parsedData, "[]")
        let filename = "timeline-test_markdown_compiles.json"
        try FileUtilities.write(parsedData, to: filename)

        let rootPath = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
        let testPath = rootPath.appendingPathComponent(filename)
        XCTAssertTrue(FileManager.default.fileExists(atPath: testPath.path))
    }
}
