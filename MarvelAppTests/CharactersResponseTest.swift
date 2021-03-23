//
//  CharactersResponseTest.swift
//  MarvelAppTests
//
//  Created by Guillem Solé Cubilo on 8/3/21.
//

import XCTest
@testable import MarvelApp

class CharactersResponseTest: XCTestCase {

    var bundle: Bundle!
    
    override func setUp() {
        self.bundle = Bundle(for: type(of: self))
    }
    
     func test_characters_response_completed() {

         guard let url = bundle.url(forResource: "CharactersResponseCompleted", withExtension: "json") else {
             XCTFail("Missing file: CharactersResponseCompleted.json")
             return
         }
        
        let jsonData = try! Data(contentsOf: url)
        
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .iso8601
        do {
            _ = try jsonDecoder.decode(CharactersResponse.self, from: jsonData)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func test_characters_response_incompleted() {

        guard let url = bundle.url(forResource: "CharactersResponseIncompleted", withExtension: "json") else {
            XCTFail("Missing file: CharactersResponseIncompleted.json")
            return
        }
       
       let jsonData = try! Data(contentsOf: url)
       
       let jsonDecoder = JSONDecoder()
       jsonDecoder.dateDecodingStrategy = .iso8601
       do {
           _ = try jsonDecoder.decode(CharactersResponse.self, from: jsonData)
       } catch {
           XCTFail(error.localizedDescription)
       }
   }
}
