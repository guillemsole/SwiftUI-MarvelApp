//
//  ContentViewModel.swift
//  MarvelApp
//
//  Created by Guillem Solé Cubilo on 5/3/21.
//

import Foundation
import Combine

final class ContentViewModel: ObservableObject {
    private var charactersService: CharactersServiceProtocol

    @Published var resultState: ResultState<[Character]> = .loading
    
    let title = "Marvel Characters"
    init(charactersService: CharactersServiceProtocol = CharactersService()) {
        self.charactersService = charactersService
        
    }
    
    func fetchCharacters() {
        charactersService.getCharacters { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let charactersResponse):
                    self.resultState = .success(charactersResponse.data.results)
                case .failure(let error):
                    self.resultState = .failed(error)
                }
            }
        }
    }
}
