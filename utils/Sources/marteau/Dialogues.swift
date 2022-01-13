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

public typealias JSONLike = [String: Any]

/// A protocol that determines the struct or class able to be parsed by the Markdown to Dialogic parser.
public protocol Dialogable {

    /// The type of dialogue interaction the class or struct falls under.
    var type: DialogueType { get }

    /// Returns a JSON-compatible dictionary.
    func toJSON() -> JSONLike
}

/// A protocol that determines the struct or class contains information about a speaker and its message.
public protocol Speakable {

    /// The speaker of the dialogue.
    var who: String { get set }

    /// The message the speaker says in the dialogue.
    var what: String { get set }
}

/// A protocol that determines that a class or struct's JSON structure can be collapsed into a singlet list of JSON-like dictionaries.
public protocol JSONCollapsible {

    /// Returns a list of JSON-like dictionaries.
    func collapseJSON() -> [JSONLike]
}

/// A basic dialogue interaction.
public struct Dialogue: Dialogable, Speakable {
    public var type: DialogueType { .dialogue }

    public var who: String = ""
    public var what: String = ""

    public func toJSON() -> JSONLike {
        [
            "character": who,
            "event_id": "dialogic_001",
            "portrait": "",
            "text": what
        ]
    }
}

/// A dialogue interaction from the narrator.
public struct Narration: Dialogable, Speakable {
    public var type: DialogueType { .narration }
    public var who: String = ""
    public var what: String = ""

    public func toJSON() -> JSONLike {
        [
            "character": "",
            "event_id": "dialogic_001",
            "portrait": "",
            "text": what
        ]
    }
}

/// A dialogue interaction that prompts the user to make a choice.
public struct Question: Dialogable, JSONCollapsible {
    public var type: DialogueType { .question }
    public var who: String = ""
    public let question: String
    public let choices: [Choice]

    public func toJSON() -> JSONLike {
        [
            "character": who,
            "event_id": "dialogic_010",
            "options": [],
            "portrait": "",
            "question": question
        ]
    }

    private func endQuestionNode() -> JSONLike {
        [
            "event_id": "dialogic_013"
        ]
    }

    public func collapseJSON() -> [JSONLike] {
        [toJSON()] + choices.flatMap { choice in choice.collapseJSON() } + [endQuestionNode()]
    }
}

/// A dialogue interaction that indicates a choice for a question.
public struct Choice: Dialogable, JSONCollapsible {
    public var type: DialogueType { .choice }
    public let choice: String
    public let dialogue: [Dialogable]

    public func toJSON() -> JSONLike {
        [
            "choice": choice,
            "condition": "",
            "definition": "",
            "event_id": "dialogic_011",
            "value": ""
        ]
    }

    public func collapseJSON() -> [JSONLike] {
        [toJSON()] + dialogue.map { dialogue in dialogue.toJSON() }
    }
}

/// A no-op dialogue interaction for commentary.
public struct Comment: Dialogable {
    public var type: DialogueType { .comment }
    public let note: String

    public func toJSON() -> JSONLike { [:] }
}
