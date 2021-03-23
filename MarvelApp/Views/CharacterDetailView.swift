//
//  CharacterDetailView\.swift
//  MarvelApp
//
//  Created by Guillem Solé Cubilo on 6/3/21.
//

import SwiftUI
import URLImage

struct CharacterDetailView: View {
    @ObservedObject var characterDetailViewModel: CharacterDetailViewModel

    init(characterId: String) {
        self.characterDetailViewModel = CharacterDetailViewModel(characterId: characterId)
    }

    var body: some View {
        VStack {
            switch characterDetailViewModel.resultState {
            case .loading:
                ProgressView()
            case .failed(let error):
                ErrorView(error: error, handler: characterDetailViewModel.fetchCharacterDetail)
            case .success(let content):
                ScrollView {
                    VStack(alignment: .leading) {
                        ZStack(alignment: .bottomLeading) {
                            if let url = content.first!.thumbnail.secureUrl {
                                URLImage(url: url,
                                         options: URLImageOptions(
                                            identifier: content.first!.id,
                                            cachePolicy: .returnCacheElseLoad(cacheDelay: nil, downloadDelay: 0.25)
                                         ),
                                         failure: { error, _ in
                                            placeholderImageView
                                         },
                                         content: { image in
                                            image.resizable()
                                                .aspectRatio(contentMode: .fit)
                                         }).overlay(Color.black.opacity(0.25))
                            } else {
                                placeholderImageView
                            }
                            Text(content.first!.name)
                                .font(.system(size: 35, weight: .heavy))
                                .padding(.leading, 15)
                                .padding(.bottom, 15)
                                
                        }
                        
                        VStack(alignment: .leading) {
                            Text(content.first!.characterDescription)
                                .padding(.top, 15)
                                
                            if let comics = content.first!.comics {
                                Text("Comics: \(comics.available)")
                                    .padding(.top, 5)
                            }
                            if let stories = content.first!.stories {
                                Text("Stories: \(stories.available)")
                                    .padding(.top, 5)
                            }
                            if let series = content.first!.series {
                                Text("Series: \(series.available)")
                                    .padding(.top, 5)
                            }
                            if let events = content.first!.events {
                                Text("Events: \(events.available)")
                                    .padding(.top, 3)
                            }
                        }
                        .font(.system(size: 15, weight: .medium))
                        .padding(.horizontal, 15)
                        Spacer()
                    }
                }
            }
        }
        .onAppear(perform: characterDetailViewModel.fetchCharacterDetail)
    }
    
    var placeholderImageView: some View {
        Image(systemName: "photo.fill")
            .foregroundColor(.white)
            .background(Color.black)
            .frame(width: 100, height: 100)
    }
}
