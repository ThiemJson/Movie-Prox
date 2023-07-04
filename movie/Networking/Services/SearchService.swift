//
//  SearchService.swift
//  movie-buff
//
//  Created by Prox on 30/04/2023.
//  Copyright © 2023 Prox. All rights reserved.
//

import Foundation
public class SearchService {
    static func searchMovie(query: BaseQuery) -> BaseResult<MediaModel> {
        return BaseRouter.searchMovies(query: query).object()
    }
    static func searchTVShow(query: BaseQuery) -> BaseResult<MediaModel> {
        return BaseRouter.searchMovies(query: query).object()
    }
    static func searchPerson(query: BaseQuery) -> BaseResult<MediaModel> {
        return BaseRouter.searchPerson(query: query).object()
    }
    static func searchMulti(query: BaseQuery) -> BaseResult<MediaModel> {
        return BaseRouter.searchMulti(query: query).object()
    }
}
