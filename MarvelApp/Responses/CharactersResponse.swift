// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - CharactersResponse
struct CharactersResponse: Codable {
    let code: Int
    let status, copyright, attributionText, attributionHTML: String
    let etag: String
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let offset, limit, total, count: Int
    let results: [Character]
}

// MARK: - Character
struct Character: Codable, Identifiable {
    let id: String
    let name: String
    let characterDescription: String
    let modified: Date
    let thumbnail: Thumbnail
    let resourceURI: String
    let comics: Comics?
    let series: Comics?
    let stories: Stories?
    let events: Comics?
    let urls: [URLElement]?

    init(id: String, name: String, characterDescription: String, modified: Date, thumbnail: Thumbnail, resourceURI: String, comics: Comics?, series: Comics?, stories: Stories?, events: Comics?, urls: [URLElement]?) {
        self.id = id
        self.name = name
        self.characterDescription = characterDescription
        self.modified = modified
        self.thumbnail = thumbnail
        self.resourceURI = resourceURI
        self.comics = comics
        self.series = series
        self.stories = stories
        self.events = events
        self.urls = urls
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        characterDescription = try container.decode(String.self, forKey: .characterDescription)
        modified = try container.decode(Date.self, forKey: .modified)
        thumbnail = try container.decode(Thumbnail.self, forKey: .thumbnail)
        resourceURI = try container.decode(String.self, forKey: .resourceURI)
        comics = try container.decode(Comics.self, forKey: .comics)
        series = try container.decode(Comics.self, forKey: .series)
        stories = try container.decode(Stories.self, forKey: .stories)
        events = try container.decode(Comics.self, forKey: .events)
        urls = try container.decode([URLElement].self, forKey: .urls)
        let idDecoded = try container.decode(Int.self, forKey: .id)
        id = String(idDecoded)
    }
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case characterDescription = "description"
        case modified, thumbnail, resourceURI, comics, series, stories, events, urls
    }

}

extension Character {
    static var dummyData: Character {
        return Character(
            id: "guillem",
            name: "A-Bomb (HAS)",
            characterDescription: "Rick Jones has been Hulk's best bud since day one, but now he's more than a friend...he's a teammate! Transformed by a Gamma energy explosion, A-Bomb's thick, armored skin is just as strong and powerful as it is blue. And when he curls into action, he uses it like a giant bowling ball of destruction! ",
            modified: Date(),
            thumbnail: Thumbnail(
                path: "http://i.annihil.us/u/prod/marvel/i/mg/3/20/5232158de5b16",
                thumbnailExtension: Extension.jpg
            ),
            resourceURI: "http://gateway.marvel.com/v1/public/characters/1017100",
            comics: nil,
            series: nil,
            stories: nil,
            events: nil,
            urls: nil
        )
    }
}

/*
 "id": 1017100,
             "name": "A-Bomb (HAS)",
             "description": "Rick Jones has been Hulk's best bud since day one, but now he's more than a friend...he's a teammate! Transformed by a Gamma energy explosion, A-Bomb's thick, armored skin is just as strong and powerful as it is blue. And when he curls into action, he uses it like a giant bowling ball of destruction! ",
             "modified": "2013-09-18T15:54:04-0400",
             "thumbnail": {
                 "path": "http://i.annihil.us/u/prod/marvel/i/mg/3/20/5232158de5b16",
                 "extension": "jpg"
             },
             "resourceURI": "http://gateway.marvel.com/v1/public/characters/1017100",
 */

// MARK: - Comics
struct Comics: Codable {
    let available: Int
    let collectionURI: String
    let items: [ComicsItem]
    let returned: Int
}

// MARK: - ComicsItem
struct ComicsItem: Codable {
    let resourceURI: String
    let name: String
}

// MARK: - Stories
struct Stories: Codable {
    let available: Int
    let collectionURI: String
    let items: [StoriesItem]
    let returned: Int
}

// MARK: - StoriesItem
struct StoriesItem: Codable {
    let resourceURI: String
    let name: String
    let type: ItemType
}

enum ItemType: String, Codable {
    case cover = "cover"
    case empty = ""
    case interiorStory = "interiorStory"
}

// MARK: - Thumbnail
struct Thumbnail: Codable {
    let path: String
    let thumbnailExtension: Extension

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
    
    var secureUrl: URL? {
        guard var components = URLComponents(string: "\(path).\(thumbnailExtension.rawValue)") else { return nil }
        
        if components.scheme == "http" {
            components.scheme = "https"
        }
        return components.url
    }
}

enum Extension: String, Codable {
    case gif = "gif"
    case jpg = "jpg"
    
    init?(rawValue: String) {
        switch rawValue {
        case "gif": self = .gif
        case "jpg": self = .jpg
        default: self = .jpg
        }
    }
}

// MARK: - URLElement
struct URLElement: Codable {
    let type: URLType
    let url: String
}

enum URLType: String, Codable {
    case comiclink = "comiclink"
    case detail = "detail"
    case wiki = "wiki"
}
