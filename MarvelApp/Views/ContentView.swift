//
//  ContentView.swift
//  MarvelApp
//
//  Created by Guillem Solé Cubilo on 5/3/21.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()
    var body: some View {
        NavigationView {
            Group {
                switch viewModel.resultState {
                case .loading:
                    ProgressView()
                case .failed(let error):
                    ErrorView(error: error, handler: viewModel.fetchCharacters)
                case .success(let characters):
                    List(characters) { character in
                        NavigationLink(destination: CharacterDetailView(characterId: character.id)) {
                            CharacterView(character: character)
                        }
                    }
                }
            }.navigationBarTitle(viewModel.title)
        }
        .accentColor(.primary)
        .onAppear(perform: viewModel.fetchCharacters)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
