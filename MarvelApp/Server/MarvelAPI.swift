//
//  MarvelAPI.swift
//  MarvelApp
//
//  Created by Guillem Solé Cubilo on 5/3/21.
//

import Foundation

protocol APIBuilder {
    var urlRequest: URLRequest { get }
    var baseUrl: URL { get }
    var apiVersion: String { get }
    var path: String { get }
    func authParams(publicKey: String, privateKey: String, timestamp: String) -> [String: String]
}

enum MarvelAPI {
    case characters
}

extension MarvelAPI : APIBuilder {
    var urlRequest: URLRequest {
        let url = self.baseUrl.appendingPathComponent(self.apiVersion + self.path)
        var components = URLComponents(string: url.absoluteString)!
        let timestamp = "\(Date().timeIntervalSince1970)"
        let authParams = self.authParams(publicKey: publicKey, privateKey: privateKey, timestamp: timestamp)
        components.queryItems = authParams.map { key, value in URLQueryItem(name: key, value: value)}
        return URLRequest(url: components.url!)
    }
    
    var baseUrl: URL {
        return URL(string: "https://gateway.marvel.com")!
    }
    
    var apiVersion: String {
        "/v1/public"
    }
    
    var path: String {
        switch self {
        case .characters:
                return "/characters"
        }
    }
    
    private var privateKey: String {
       "privateKey"
    }
    
    private var publicKey: String {
        "publicKey"
    }
    
    func authParams(publicKey: String, privateKey: String, timestamp: String) -> [String: String] {
        let rawHash = timestamp + publicKey + privateKey
        return [
            "ts": timestamp,
            "apikey": publicKey,
            "hash": rawHash.MD5
        ]
    }
}
