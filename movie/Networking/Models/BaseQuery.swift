//
//  BaseQuery.swift
//  movie-buff
//
//  Created by Prox on 30/04/2023.
//  Copyright © 2023 Prox. All rights reserved.
//

import Foundation
struct BaseQuery : Codable {
    var query                           : String?
    var append_to_response              : String?
    var with_genres                     : Int?
    var size        : Int?              = 10
    var page        : Int?              = 1
    var api_key     : String?           = BaseRouter.api_key
    var sort_by                         : String? = "primary_release_date.desc"
    
    mutating func toJSON() -> [String: Any] {
        return self.convertObjectToJson()?.dictionaryObject ?? [:]
    }
}
