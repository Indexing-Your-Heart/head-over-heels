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

@main
struct Marteau: ParsableCommand {

    static let configuration = CommandConfiguration(
        abstract: "A set of utilities for Indexing Your Heart.",
        subcommands: [Dialogue.self]
    )

    struct Dialogue: ParsableCommand {
        static let configuration = CommandConfiguration(abstract: "Converts a Markdown document into Dialogic JSON.")

        @Argument(help: "The path to the markdown file to convert.")
        var markdownFile: String

        @Argument(help: "The path to where the output JSON file should go.")
        var outputFile: String = "timeline.json"

        func validate() throws {
            guard markdownFile.hasSuffix(".md") else {
                throw ValidationError("Supplied file must be a Markdown (.md) file.")
            }
        }

        func run() throws {
            let markdownText = try FileUtilities.read(from: markdownFile, encoding: .utf8)
            let resultData = MarkdownDialogicParser(from: markdownText).compileToString()
            try FileUtilities.write(resultData, to: outputFile, encoding: .utf8)
        }
    }

}
