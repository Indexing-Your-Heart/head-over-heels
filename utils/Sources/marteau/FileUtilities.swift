//
//  FileUtilities.swift
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

/// A struct containing utilities for reading and writing files.
public struct FileUtilities {

    /// Write the string contents to a corresponding filepath, relative to where the program is run from.
    public static func write(_ contents: String, to filepath: String, encoding: String.Encoding = .utf8) throws {
        let rootPath = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
        let outPath = rootPath.appendingPathComponent(filepath)
        try contents.write(to: outPath, atomically: false, encoding: encoding)
    }
}
