//
//  DefaultModel.swift
//  movie-buff
//
//  Created by Prox on 30/04/2023.
//  Copyright © 2023 Prox. All rights reserved.
//

import Foundation

protocol DefaultModel {
    var page            : Int?  { get set }
    var totalResults    : Int?  { get set }
    var totalPages      : Int?  { get set }
    mutating func toJSON() -> [String: Any]
}

protocol DefaultErrorModel {
    var message : String?  { get set }
    var code    : Int?  { get set }
}
