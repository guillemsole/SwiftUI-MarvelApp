//
//  MarvelAPI.swift
//  MarvelAppTests
//
//  Created by Guillem Solé Cubilo on 5/3/21.
//

import XCTest
@testable import MarvelApp

class MarvelRequestTests: XCTestCase {

    func test_url_request() {
        XCTAssertNoThrow(URLRequest(endpoint: MarvelEndpoint.characters))
    }
    
    func test_url_request_params_check() {
        let timestamp: TimeInterval = 5000000
        let urlRequest = URLRequest(endpoint: MarvelEndpoint.characters, timestamp: timestamp)
        XCTAssertTrue(urlRequest!.url!.absoluteString == "https://gateway.marvel.com/v1/public/characters?ts=5000000.0&apikey=a461a1c77ed0b74733071e8d794f429d&hash=90ab655e3f5d4ef5148f386a211ccae1")
    }
    
    func test_marvel_endpoing_path() {
        XCTAssertTrue(MarvelEndpoint.characters.path == "/characters")
    }
}
