//
//  APIErrorTests.swift
//  MarvelAppTests
//
//  Created by Guillem Solé Cubilo on 5/3/21.
//

import XCTest
@testable import MarvelApp

class MarvelErrorTests: XCTestCase {
    
    func test_status_code_error_description() {
        let errorCode = MarvelError.errorCode(500)
        print(errorCode.localizedDescription)
        XCTAssertTrue(errorCode.localizedDescription == "500 - Something went wrong")
    }
}
