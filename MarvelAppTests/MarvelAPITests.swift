//
//  MarvelAPI.swift
//  MarvelAppTests
//
//  Created by Guillem Solé Cubilo on 5/3/21.
//

import XCTest
@testable import MarvelApp

class MarvelAPITests: XCTestCase {

    func test_auth_params() {
        let timestamp = "100000000"
        let publicKey = "publicKey"
        let privateKey = "privateKey"
        let authParams: [String: String] = MarvelAPI.characters.authParams(publicKey: publicKey, privateKey: privateKey, timestamp: timestamp)
        print(authParams)
        XCTAssertTrue(authParams["ts"] == timestamp)
        XCTAssertTrue(authParams["apikey"] == publicKey)
        XCTAssertTrue(authParams["hash"] == "67ab260329ae13c9a823e8de37ea2629")
        
    }
    
    func test_url_request() {
        let urlRequest = MarvelAPI.characters.urlRequest
        
        XCTAssertTrue(urlRequest.url?.absoluteString.contains("https://gateway.marvel.com/v1/public/characters") == true)
    }
}
