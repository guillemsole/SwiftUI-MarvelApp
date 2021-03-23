//
//  Endpoint.swift
//  MarvelApp
//
//  Created by Guillem Solé Cubilo on 8/3/21.
//

import Foundation

//sourcery: AutoMockable
//sourcery: associatedtype = "Response: Codable"
public protocol Endpoint {
    var path: String {get}
    var method: RequestMethod {get}
    var parameters: [String: Any] { get }
    var documentId: String? {get}
    
    associatedtype Response: Decodable
}

public enum RequestMethod: String {
    case post = "POST"
    case get = "GET"
    case delete = "DELETE"
}

// Define default endpoint parameters
public extension Endpoint {

    var method: RequestMethod {
        .get
    }
    
    var parameters: [String: Any] {
        [:]
    }
}
