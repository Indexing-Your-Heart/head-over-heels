//
//  CharacterParse.swift
//  Created by Marquis Kurt on 12/1/22.
//  This file is part of Indexing Your Heart.
//
//  Indexing Your Heart is non-violent software: you can use, redistribute, and/or modify it under the terms of the
//  CNPLv7+ as found in the LICENSE file in the source code root directory or at
//  <https://git.pixie.town/thufie/npl-builder>.
//
//  Indexing Your Heart comes with ABSOLUTELY NO WARRANTY, to the extent permitted by applicable law. See the CNPL for
//  details.

import Foundation

public struct DialogicPortrait: Codable {
    public var name: String
    public var path: String
}

public struct DialogicCharacter: Codable, Identifiable {
    public var color: String
    public var description: String
    public var displayName: String
    public var displayNameBool: Bool
    public var id: String
    public var mirrorPortraits: Bool
    public var name: String
    public var nickname: String
    public var nicknameBool: Bool
    public var offsetX: Int
    public var offsetY: Int
    public var portraits: [DialogicPortrait]
    public var scale: Int

    private enum CodingKeys: String, CodingKey {
        case color
        case description
        case displayName = "display_name"
        case displayNameBool = "display_name_bool"
        case id
        case mirrorPortraits = "mirror_portraits"
        case name
        case nickname
        case nicknameBool = "nickname_bool"
        case offsetX = "offset_x"
        case offsetY = "offset_y"
        case portraits
        case scale
    }

    public func getAllNames() -> [String] {
        [name, displayName] + nickname.split(separator: ",").map { String($0) }
    }
}

