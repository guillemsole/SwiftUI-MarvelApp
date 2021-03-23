//
//  CharactersServiceTests.swift
//  MarvelAppTests
//
//  Created by Guillem Solé Cubilo on 8/3/21.
//

import XCTest
@testable import MarvelApp
import SwiftyMocky

class CharactersServiceTests: XCTestCase {

    var sut: APIRestProvider!
    var urlSession: URLSessionProtocolMock!
    var endpoint: EndpointMock<CharactersResponse>!
    var bundle: Bundle!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        urlSession = URLSessionProtocolMock()
        endpoint = EndpointMock<CharactersResponse>()
        sut = APIRestProvider(session: urlSession)
        bundle = Bundle(for: type(of: self))
        
        Given(endpoint, .path(getter: "/path"))
        Given(endpoint, .baseURL(getter: "https://test.url.com"))
        Given(endpoint, .method(getter: .get))
        Given(urlSession, .dataTask(with: .any, completionHandler: .any, willReturn: URLSession.shared.dataTask(with: URL(string: "url")!, completionHandler: {_,_,_ in})))
    }
    
    func test_request_whenStatusCode200_andResponseDataIsCharactersResponse_successToDecodeData() {
        guard let url = bundle.url(forResource: "CharactersResponseCompleted", withExtension: "json") else {
            XCTFail("CharactersResponseCompleted fail not found")
            return
        }
        
        let data = try! Data(contentsOf: url)
        Perform(urlSession, .dataTask(with: .any, completionHandler: .any, perform: {request, completion in
            completion(data, HTTPURLResponse(url: URL(string: "url")!, statusCode: 200, httpVersion: nil, headerFields: nil), nil)
        }))
        
        var decodedResponse: CharactersResponse?
        sut.request(endpoint: endpoint) { result in
            switch result {
            case .success(let response):
                decodedResponse = response
            case .failure(_):
                XCTFail("Response must be decoded correctly")
            }
        }
        
        XCTAssertNotNil(decodedResponse)
    }
    
    func test_request_whenStatusCode200_andResponseDataIsIncomplete_failsWithDecodingError() {
        guard let url = bundle.url(forResource: "CharactersResponseIncompleted", withExtension: "json") else {
            XCTFail("CharactersResponseIncompleted fail not found")
            return
        }
        
        let data = try! Data(contentsOf: url)
        Perform(urlSession, .dataTask(with: .any, completionHandler: .any, perform: {request, completion in
            completion(data, HTTPURLResponse(url: URL(string: "url")!, statusCode: 200, httpVersion: nil, headerFields: nil), nil)
        }))
        
        var expectedError: MarvelError?
        sut.request(endpoint: endpoint) { result in
            switch result {
            case .success:
                XCTFail("Response must be decoding error")
            case .failure(let decodingError):
                print(decodingError.localizedDescription)
                expectedError = decodingError
            }
        }
        
        XCTAssertEqual(expectedError?.localizedDescription, "The data couldn’t be read because it is missing.")
    }


}
