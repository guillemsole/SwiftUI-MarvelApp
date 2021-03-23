//
//  RestProvider.swift
//  MarvelApp
//
//  Created by Guillem Solé Cubilo on 8/3/21.
//

import Foundation

//sourcery: AutoMockable
protocol APIRestProviderProtocol {
    func request<T: Endpoint>(endpoint: T, completion: @escaping (Result<T.Response, MarvelError>) -> Void)
}

struct NetworkConfiguration {
    static var baseURL: String {
        Bundle.main.object(forInfoDictionaryKey: "base-url") as! String
    }
    static var publicKey: String {
        Bundle.main.object(forInfoDictionaryKey: "public-key") as! String
    }
    static var privateKey: String {
        Bundle.main.object(forInfoDictionaryKey: "private-key") as! String
    }
}

struct APIRestProvider: APIRestProviderProtocol {
    
    private var session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }

    func request<T: Endpoint>(endpoint: T, completion: @escaping (Result<T.Response, MarvelError>) -> Void) {
        let request = endpoint.request()
        self.session.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(.returnedError(error)))
                }
            }
            
            if let data = data,
               let response = response as? HTTPURLResponse {
                if (200...299).contains(response.statusCode) {
                    do {
                        let jsonDecoder = JSONDecoder()
                        jsonDecoder.dateDecodingStrategy = .iso8601
                        let items = try jsonDecoder.decode(T.Response.self, from: data)
                        completion(.success(items))
                    } catch let decodingError as DecodingError {
                        completion(.failure(MarvelError.decodingError(decodingError)))
                    } catch {
                        completion(.failure(MarvelError.customError("Decoding failed for unknown reasons.")))
                    }
                } else {
                    completion(.failure(.errorCode(response.statusCode)))
                }
            } else {
                completion(.failure(.dataReturnedNil))
            }
        }.resume()
    }
}

fileprivate extension Endpoint {
    func request(timestamp: TimeInterval = Date().timeIntervalSince1970) -> URLRequest {
        let fullURL = NetworkConfiguration.baseURL + path
        guard var components = URLComponents(string: fullURL) else {
            fatalError("Base URL \(fullURL) is not in the correct format")
        }

        let rawHash = timestamp.description + NetworkConfiguration.privateKey + NetworkConfiguration.publicKey
        components.queryItems = [
            URLQueryItem(name: "ts", value: timestamp.description),
            URLQueryItem(name: "apikey", value: NetworkConfiguration.publicKey),
            URLQueryItem(name: "hash", value: rawHash.MD5)
        ]
        
        guard let url = components.url else {
            fatalError("Query Items are not in the correct format")
        }

        return URLRequest(url: url)
    }
}

