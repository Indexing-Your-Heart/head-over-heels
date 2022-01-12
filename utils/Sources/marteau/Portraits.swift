//
//  Portraits.swift
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

public class PortraitManager {
    var characters: [DialogicCharacter]
    var images: [String: [DialogicPortrait]] = [:]

    public init(for characters: [DialogicCharacter]) {
        self.characters = characters
        for character in characters {
            self.images[character.name] = character.portraits
        }
    }

    public static func sortPortraits(for character: DialogicCharacter) -> DialogicCharacter {
        var newCharacter = character
        newCharacter.portraits = newCharacter.portraits.sorted { $0.name < $1.name }
        return newCharacter
    }

    public func addPortraitPath(_ path: String, to character: String) {
        if var portraits = self.images[character] {
            portraits.append(
                DialogicPortrait(name: path, path: path)
            )
        } else {
            self.images[character] = [DialogicPortrait(name: path, path: path)]
        }
    }

    public func updatePortraits() -> [DialogicCharacter] {
        self.characters.map { character in
            var newCharacter = character
            newCharacter.portraits = self.images[character.name]!
            return PortraitManager.sortPortraits(for: newCharacter)
        }
    }
}
