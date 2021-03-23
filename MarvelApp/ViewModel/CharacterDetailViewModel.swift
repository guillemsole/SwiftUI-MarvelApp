//
//  CharacterDetailViewModel.swift
//  MarvelApp
//
//  Created by Guillem Solé Cubilo on 6/3/21.
//

import Foundation
import Combine

final class CharacterDetailViewModel: ObservableObject {
    private(set) var characterId: String
    
    @Published var resultState: ResultState<[Character]> = .loading
    
    private var charactersService: CharactersServiceProtocol

    init(characterId: String, charactersService: CharactersServiceProtocol = CharactersService()) {
        self.characterId = characterId
        self.charactersService = charactersService
    }
    
    func fetchCharacterDetail() {
        charactersService.getCharacterById(id: self.characterId) { result in
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
