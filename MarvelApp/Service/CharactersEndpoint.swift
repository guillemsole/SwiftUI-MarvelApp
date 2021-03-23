//
//  CharactersEndoint.swift
//  MarvelApp
//
//  Created by Guillem Solé Cubilo on 8/3/21.
//

import Foundation

struct CharactersEndpoint: Endpoint {
    var documentId: String?
    
    var path: String {
        "/characters"
    }
        
    typealias Response = CharactersResponse
    
}
