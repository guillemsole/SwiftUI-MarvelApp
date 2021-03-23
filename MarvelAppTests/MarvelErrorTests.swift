//
//  APIErrorTests.swift
//  MarvelAppTests
//
//  Created by Guillem Solé Cubilo on 5/3/21.
//

import XCTest
@testable import MarvelApp


class MarvelErrorTests: XCTestCase {
    
    func test_status_code_error_verify_description() {
        let errorCode = MarvelError.errorCode(500)
        print(errorCode.localizedDescription)
        XCTAssertTrue(errorCode.localizedDescription == "500 - Something went wrong")
    }
    
    func test_returnedError_verify_description() {
        let returnedError = MarvelError.returnedError(AnyError.any)
        XCTAssertTrue(returnedError.localizedDescription == AnyError.any.localizedDescription)
    }
    
    func test_decoding_error_verify_description() {
        let decodingError = MarvelError.decodingError(AnyError.any)
        XCTAssertTrue(decodingError.localizedDescription == AnyError.any.localizedDescription)
    }
    
    func test_unknown_error_verify_description() {
        let unknownError = MarvelError.unknown
        XCTAssertTrue(unknownError.localizedDescription == "The error is unknown")
    }
}
