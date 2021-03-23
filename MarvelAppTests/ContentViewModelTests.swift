//
//  ContentViewModelTests.swift
//  MarvelAppTests
//
//  Created by Guillem Solé Cubilo on 8/3/21.
//

import XCTest
@testable import MarvelApp
import SwiftyMocky

class ContentViewModelTests: XCTestCase {

    var sut: ContentViewModel!
    var charactersService: CharactersServiceProtocolMock!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        charactersService = CharactersServiceProtocolMock()
        sut = ContentViewModel(charactersService: charactersService)
    }
    
    func test_viewModelTitle_verifyDescription() {
        XCTAssertEqual(sut.title, "Marvel Characters")
    }
    
    func test_viewModelResultStatusIsLoading_whenCreated() {
        XCTAssertEqual(sut.resultState, ResultState.loading)
    }
    
    func test_viewModelResultStateIsFailed_whenCharacterServiceReturnsAnError() {
        let expectation = XCTestExpectation()

        Perform(charactersService, .getCharacters(.any, perform: { completion in
            completion(.failure(MarvelError.dataReturnedNil))
        }))
        var expectedError: MarvelError?
        
        _ = sut.$resultState.sink { result in
            switch result {
            case .failed(let error):
                expectedError = error
            case .success, .loading:
                XCTFail("State must be failed")
            break
            }
            expectation.fulfill()
        }
        sut.fetchCharacters()

        
        XCTAssertNotNil(expectedError)
        wait(for: [expectation], timeout: 5)
    }
    
    func test_viewModelResultStateIsSuccess_whenCharactersServiceReturnsAResponse() {
        
    }
}
