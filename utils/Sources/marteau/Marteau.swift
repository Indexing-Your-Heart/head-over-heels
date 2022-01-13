//
//  Marteau.swift
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
import ArgumentParser

/// The main entry struct that holds all of the program commands.
@main
struct Marteau: ParsableCommand {

    /// The configuration for the main program.
    static let configuration = CommandConfiguration(
        abstract: "A set of utilities for Indexing Your Heart.",
        subcommands: [Dialogue.self]
    )

    /// The subcommand struct for dialogue conversion.
    struct Dialogue: ParsableCommand {
        static let configuration = CommandConfiguration(abstract: "Converts a Markdown document into Dialogic JSON.")

        /// The path to the Markdown file to convert.
        @Argument(help: "The path to the Markdown file to convert.")
        var markdownFile: String

        /// The path to where the out JSON file should go.
        @Argument(help: "The path to where the output JSON file should go.")
        var outputFile: String = "timeline.json"

        /// (Optional) The path to a directory of character definitions in Dialogic format.
        @Option(help: "The path to a directory of character definitions.")
        var characters: String?

        func validate() throws {
            guard markdownFile.hasSuffix(".md") else {
                throw ValidationError("Supplied file must be a Markdown (.md) file.")
            }
        }

        func run() throws {
            let markdownText: String = try FileUtilities.read(from: markdownFile, encoding: .utf8)
            let parser = MarkdownDialogicParser(from: markdownText)
            print("[i] Parser created.")
            if let charpath = characters {
                let characterGlobs = try FileUtilities.readAll(from: charpath)
                parser.characterDefinitions = try characterGlobs
                    .map { try JSONDecoder().decode(DialogicCharacter.self, from: $0) }
                print("[i] Character definitions added.")
            }
            let resultData = parser.compileToString()
            try FileUtilities.write(resultData, to: outputFile, encoding: .utf8)
        }
    }

}
