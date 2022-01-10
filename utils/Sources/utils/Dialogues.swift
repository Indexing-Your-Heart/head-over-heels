//
//  Dialogues.swift
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

/// A protocol that determines the struct or class able to be parsed by the Markdown to Dialogic parser.
public protocol Dialogable {

    /// The type of dialogue interaction the class or struct falls under.
    var type: DialogueType { get }
}

/// A protocol that determines the struct or class contains information about a speaker and its message.
public protocol Speakable {

    /// The speaker of the dialogue.
    var who: String { get set }

    /// The message the speaker says in the dialogue.
    var what: String { get set }
}

/// A basic dialogue interaction.
public struct Dialogue: Dialogable, Speakable {
    public var type: DialogueType { .dialogue }

    public var who: String
    public var what: String
}

/// A dialogue interaction from the narrator.
public struct Narration: Dialogable, Speakable {
    public var type: DialogueType { .narration }
    public var who: String = "Narrator"
    public var what: String
}

/// A dialogue interaction that prompts the user to make a choice.
public struct Question: Dialogable {
    public var type: DialogueType { .question }
    public let question: String
    public let choices: [Choice]
}

/// A dialogue interaction that indicates a choice for a question.
public struct Choice: Dialogable {
    public var type: DialogueType { .choice }
    public let choice: String
    public let dialogue: [Dialogue]
}

/// A no-op dialogue interaction for commentary.
public struct Comment: Dialogable {
    public var type: DialogueType { .comment }
    public let note: String
}
