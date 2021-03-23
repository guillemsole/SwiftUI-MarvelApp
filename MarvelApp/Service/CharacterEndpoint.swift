//
//  CharacterEndpoint.swift
//  MarvelApp
//
//  Created by Guillem Solé Cubilo on 8/3/21.
//

import Foundation

struct CharacterEndpoint: Endpoint {
    var documentId: String?
    
    typealias Response = CharactersResponse
    
    init(id: String) {
        self.documentId = id
    }

    var path: String {
        "/characters/" + self.documentId!
    }
}
