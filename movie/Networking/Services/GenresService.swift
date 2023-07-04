//
//  GenresService.swift
//  movie-buff
//
//  Created by Prox on 08/05/2023.
//  Copyright © 2023 Prox. All rights reserved.
//

import Foundation
public class GenresService {
    static func get_genresTv(query: BaseQuery) -> BaseResult<GenresModel> {
        return BaseRouter.genres_tv(query: query).object()
    }
    static func get_genresMovie(query: BaseQuery) -> BaseResult<GenresModel> {
        return BaseRouter.genres_movie(query: query).object()
    }
}
