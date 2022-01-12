//
//  FileUtilitiesTests.swift
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
import XCTest
import marteau

/// Tests for the FileUtilities class.
class FileUtilitiesTests: XCTestCase {

    /// Test that FileUtilities can write a string into a file.
    func testCanWriteToFile() throws {
        let filename = "test.txt"
        try FileUtilities.write("Hello, world!", to: filename)

        let originalPath = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
        let filePath = originalPath.appendingPathComponent(filename)
        XCTAssertTrue(FileManager.default.fileExists(atPath: filePath.path))
    }

    /// Test that FileUtilities can read a file as a string.
    func testCanReadFromFile() throws {
        let filename = "test.txt"
        try FileUtilities.write("Hello, world!", to: filename)

        let text = try FileUtilities.read(from: filename)
        XCTAssertTrue(text.contains("Hello, world!"))
    }

}
