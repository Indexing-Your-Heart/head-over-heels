//
//  utilsTests.swift
//  Created by Marquis Kurt on 10/1/22.
//  This file is part of Indexing Your Heart.
//
//  Indexing Your Heart is non-violent software: you can use, redistribute, and/or modify it under the terms of the
//  CNPLv7+ as found in the LICENSE file in the source code root directory or at
//  <https://git.pixie.town/thufie/npl-builder>.
//
//  Indexing Your Heart comes with ABSOLUTELY NO WARRANTY, to the extent permitted by applicable law. See the CNPL for
//  details.
import XCTest
import utils

final class utilsTests: XCTestCase {
    func testMarkdownParsing() throws {
        let example = """
        Slowly, I walk over to the bar. I'm not sure if I can handle it.

        Player: "Can I get a drink?"  
        Bartender: "Sure, what can I get you?"

        - (Choice)
            - "A beer."
                - Bartender: "Sure thing."
            - "A glass of wine."
                - Bartender: "Are you sure about that?"

        > Note: This should be ignored! Disregard this comment.
        """
        let parsedData = MarkdownDialogicParser(from: example).parse()
        print(parsedData)

        XCTAssertEqual(parsedData.count, 5)
    }
}
