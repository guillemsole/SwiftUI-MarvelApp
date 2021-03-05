//
//  String+HashTests.swift
//  MarvelAppTests
//
//  Created by Guillem Solé Cubilo on 5/3/21.
//

import XCTest
@testable import MarvelApp

class String_HashTests: XCTestCase {

    func test_md5_short_text_success() {
        let rawText = "1abcd1234"
        let md5Text = rawText.MD5
        XCTAssertTrue(md5Text == "ffd275c5130566a2916217b101f26150")
    }

    func test_md5_long_text_success() {
        let rawText = "12345678910abcdefghijklmopqrstuwxyz"
        let md5Text = rawText.MD5
        XCTAssertTrue(md5Text == "773ec7c9a0af0f485ab5bbd4a34abc2a")
    }
    
    func test_md5_text_success() {
        let rawText = "1abcd1234"
        let md5Text = rawText.MD5
        XCTAssertTrue(md5Text != rawText)
    }
}
