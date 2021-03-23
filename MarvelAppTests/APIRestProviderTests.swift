//
//  RestProviderTests.swift
//  MarvelAppTests
//
//  Created by Guillem Solé Cubilo on 8/3/21.
//

import XCTest
@testable import MarvelApp
import SwiftyMocky

struct MockResponse: Codable, Equatable {
    let title: String
}

class APIRestProviderTests: XCTestCase {
    var sut: APIRestProvider!
    var urlSession: URLSessionProtocolMock!
    var endpoint: EndpointMock<MockResponse>!

    override func setUp()  {
        urlSession = URLSessionProtocolMock()
        sut = APIRestProvider(session: urlSession)
        endpoint = EndpointMock<MockResponse>()
        
        Given(endpoint, .path(getter: "/path"))
        Given(endpoint, .method(getter: .get))
        Given(endpoint, .baseURL(getter: "url"))
        Given(urlSession, .dataTask(with: .any, completionHandler: .any, willReturn: URLSession.shared.dataTask(with: URL(string: "url")!, completionHandler: {_, _, _ in })))
    }
    
    func test_request_callsDataTast() {
        sut.request(endpoint: endpoint) { _ in }
        Verify(urlSession, .dataTask(with: .any, completionHandler: .any))
    }
    
    func test_request_whenNilDataIsReturned_failsWithDataReturnedNilError() {

        Perform(urlSession, .dataTask(with: .any, completionHandler: .any, perform: {request, completion in
            completion(nil, nil, MarvelError.dataReturnedNil)
        }))
        
        var expectedError: MarvelError?
        sut.request(endpoint: endpoint) { result in
            switch result {
            case .success:
                XCTFail("Server call must not succeed")
            case .failure(let error):
                expectedError = error
            }
        }

        XCTAssertEqual(expectedError, MarvelError.dataReturnedNil)
    }
    
    func test_request_whenErrorCodeReturned_failsWithErrorCodeError() {
        let notFoundErrorCode = 404
        let mockData = try! JSONEncoder().encode(MockResponse(title: "title"))
        Perform(urlSession, .dataTask(with: .any, completionHandler: .any, perform: {request, completion in
            completion(mockData, HTTPURLResponse(url: URL(string: "url")!, statusCode: notFoundErrorCode, httpVersion: nil, headerFields: nil), nil)
        }))
        
        var expectedError: MarvelError?
        sut.request(endpoint: endpoint) { result in
            switch result {
            case .success:
                XCTFail("Server call must not succeed")
            case .failure(let error):
                expectedError = error
            }
        }
        
        XCTAssertEqual(expectedError, MarvelError.errorCode(notFoundErrorCode))
    }
    
    func test_request_whenStatusIsOK_butDecodingFails_failsWithDecodingError() {
        let mockData = try! JSONEncoder().encode(["wrong":"decoding"])
        Perform(urlSession, .dataTask(with: .any, completionHandler: .any, perform: {request, completion in
            completion(mockData, HTTPURLResponse(url: URL(string: "title")!, statusCode: 200, httpVersion: nil, headerFields: nil), nil)
        }))
        
        var expectedError: MarvelError?
        sut.request(endpoint: endpoint) { result in
            switch result {
            case .success:
                XCTFail("Server call must not succeed")
            case .failure(let error):
                if case .decodingError(_) = error {
                    expectedError = error
                }
            }
        }
        
        XCTAssertNotNil(expectedError)
    }
    
    func test_request_whenStatusIsOk_andDecodingWorksFine_succeeds() {
        let okeyStatusCode = 200
        let response = MockResponse(title: "title")
        let mockData = try! JSONEncoder().encode(response)
        Perform(urlSession, .dataTask(with: .any, completionHandler: .any, perform: {request, completion in
            completion(mockData, HTTPURLResponse(url: URL(string: "url")!, statusCode: okeyStatusCode, httpVersion: nil, headerFields: nil), nil)
        }))
        
        var completionResponse: MockResponse?
        sut.request(endpoint: endpoint) { result in
            switch result {
            case .success(let result):
                completionResponse = result
            case .failure:
                XCTFail("Server call must succeed")
            }
        }
        
        XCTAssertEqual(response, completionResponse)
    }
    
    
}
