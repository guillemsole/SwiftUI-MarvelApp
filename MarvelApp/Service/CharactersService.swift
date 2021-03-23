//
//  CharactersService.swift
//  MarvelApp
//
//  Created by Guillem Solé Cubilo on 5/3/21.
//

import Foundation
import Combine

//sourcery: AutoMockable
protocol CharactersServiceProtocol {
    func getCharacters(_ completionHandler: @escaping (Result<CharactersResponse, MarvelError>) -> Void)
    func getCharacterById(id: String, _ completionHandler: @escaping (Result<CharactersResponse, MarvelError>) -> Void)
}

struct CharactersService: CharactersServiceProtocol {
    private let session: URLSessionProtocol
    private let restProvider: APIRestProviderProtocol
    
    init(restProvider: APIRestProviderProtocol = APIRestProvider(),
         session: URLSessionProtocol = URLSession.shared) {
        self.session = session
        self.restProvider = restProvider
    }
    
    func getCharacters(_ completionHandler: @escaping (Result<CharactersResponse, MarvelError>) -> Void) {
        restProvider.request(endpoint: CharactersEndpoint(), completion: completionHandler)
    }
    
    func getCharacterById(id: String, _ completionHandler: @escaping (Result<CharactersResponse, MarvelError>) -> Void) {
        restProvider.request(endpoint: CharacterEndpoint(id: id), completion: completionHandler)
    }
    
    func getCharacters() -> AnyPublisher<CharactersResponse, MarvelError> {
        guard let request = URLRequest(endpoint: .getCharacters) else {
            return Fail(error: MarvelError.unknown).eraseToAnyPublisher()
        }
        return self.session
            .dataTaskPublisher(for: request)
            .receive(on: DispatchQueue.main)
            .mapError { _ in MarvelError.unknown}
            .flatMap { data, response -> AnyPublisher<CharactersResponse, MarvelError> in
                guard let response = response as? HTTPURLResponse else {
                    return Fail(error: MarvelError.unknown).eraseToAnyPublisher()
                }
                
                if (200...299).contains(response.statusCode) {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    return Just(data)
                        .decode(type: CharactersResponse.self, decoder: decoder)
                        .mapError { error in
                            return MarvelError.decodingError(error)
                        }.eraseToAnyPublisher()
                } else {
                    return Fail(error: MarvelError.errorCode(response.statusCode)).eraseToAnyPublisher()
                }
            }.eraseToAnyPublisher()
        
    }
    
    
    
    func getCharacter(id: String) -> AnyPublisher<CharactersResponse, MarvelError> {
        guard let request = URLRequest(endpoint: .getCharacterById(id: id)) else {
            return Fail(error: .unknown).eraseToAnyPublisher()
        }
        
        return self.session
            .dataTaskPublisher(for: request)
            .receive(on: DispatchQueue.main)
            .mapError {_ in MarvelError.unknown}
            .flatMap { data, response -> AnyPublisher<CharactersResponse, MarvelError> in
                guard let response = response as? HTTPURLResponse else {
                    return Fail(error: MarvelError.unknown).eraseToAnyPublisher()
                }
                
                if (200...299).contains(response.statusCode) {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    return Just(data)
                        .decode(type: CharactersResponse.self, decoder: decoder)
                        .mapError { error in MarvelError.decodingError(error)}
                        .eraseToAnyPublisher()
                } else {
                    return Fail(error: MarvelError.errorCode(response.statusCode)).eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
}
