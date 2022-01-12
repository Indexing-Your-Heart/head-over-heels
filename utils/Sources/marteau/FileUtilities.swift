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

    public enum FError: Error {
        case fileNotFound
    }

    /// Write the string contents to a corresponding filepath, relative to where the program is run from.
    /// - Parameter contents: The contents of the file that will be written.
    /// - Parameter filepath: The path to the file that will be written.
    /// - Parameter encoding: The encoding of the file.
    public static func write(_ contents: String, to filepath: String, encoding: String.Encoding = .utf8) throws {
        let rootPath = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
        let outPath = rootPath.appendingPathComponent(filepath)
        try contents.write(to: outPath, atomically: false, encoding: encoding)
    }

    /// Read the contents of the file at the requested file path as a string.
    /// - Parameter filepath: The path to the file to read.
    /// - Parameter encoding: The encoding of the file.
    /// - Returns: A string containing the contents of the file.
    public static func read(from filepath: String, encoding: String.Encoding = .utf8) throws -> String {
        let filePath = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
        let inPath = filePath.appendingPathComponent(filepath)
        if let fileData = FileManager.default.contents(atPath: inPath.path) {
            return String(data: fileData, encoding: encoding)!
        } else {
            throw FError.fileNotFound
        }
    }

    /// Read the contents of the file at the requested file path as a string.
    /// - Parameter filepath: The path to the file to read.
    /// - Parameter encoding: The encoding of the file.
    /// - Returns: A Data object containing the contents of the file.
    public static func read(from filepath: String, encoding: String.Encoding = .utf8) throws -> Data {
        let filePath = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
        let inPath = filePath.appendingPathComponent(filepath)
        if let fileData = FileManager.default.contents(atPath: inPath.path) {
            return fileData
        } else {
            throw FError.fileNotFound
        }
    }

    public static func readAll(from directory: String, encoding: String.Encoding = .utf8) throws -> [Data] {
        let filePath = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
        let inPath = filePath.appendingPathComponent(directory)
        return try FileManager.default.contentsOfDirectory(atPath: inPath.path)
            .map { try read(from: directory + $0, encoding: encoding) }
    }
}
