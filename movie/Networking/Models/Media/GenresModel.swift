//
//  GenresModel.swift
//  movie-buff
//
//  Created by Prox on 08/05/2023.
//  Copyright © 2023 Prox. All rights reserved.
//

import Foundation
struct GenresModel: Codable {
    var genres          : [Genre] = []
    
    mutating func toJSON() -> [String: Any] {
        return self.convertObjectToJson()?.dictionaryObject ?? [:]
    }
}

// MARK: - Genre
struct Genre: Codable {
    var id: Int?
    var name: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
    
    init(from decoder: Decoder) throws {
        let container           = try decoder.container(keyedBy: CodingKeys.self)
        id = try? container.decodeIfPresent(Int.self, forKey: .id)
        name = try? container.decodeIfPresent(String.self, forKey: .name)
    }
}
