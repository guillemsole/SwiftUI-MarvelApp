//
//  CharacterView.swift
//  MarvelApp
//
//  Created by Guillem Solé Cubilo on 5/3/21.
//

import SwiftUI
import URLImage

struct CharacterView: View {
    let character: Character
    var body: some View {
        HStack {
            characterImage
            VStack(alignment: .leading) {
                Text(character.name)
                    .font(.title)
                Text(character.characterDescription)
                    .foregroundColor(.gray)
                    .font(.footnote)
            }
            .padding(.leading, 15)
        }
    }
    
    
    private var characterImage: some View {
        Group {
            if let url = character.thumbnail.secureUrl {
                URLImage(url: url,
                         options: URLImageOptions(
                            identifier: "\(character.id)",
                            cachePolicy: .returnCacheElseLoad(cacheDelay: nil, downloadDelay: 0.25)
                         ),
                         failure: { error, _ in
                            placeholderImageView
                         },
                         content: { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fill)
                         }).frame(width: 100, height: 100)
                    .cornerRadius(10)
            } else {
                placeholderImageView
            }
        }
    }
    
    var placeholderImageView: some View {
        Image(systemName: "photo.fill")
            .foregroundColor(.white)
            .background(Color.black)
            .frame(width: 100, height: 100)
    }
}

struct CharacterView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterView(character: Character.dummyData)
            .previewLayout(.sizeThatFits)
    }
}
