//
//  MoviesService.swift
//  movie-buff
//
//  Created by Prox on 08/05/2023.
//  Copyright © 2023 Prox. All rights reserved.
//

import Foundation
public class MoviesService {
    static func get_movieByGenres(query: BaseQuery) -> BaseResult<MovieModel> {
        return BaseRouter.genres_discover_movie(query: query).object()
    }
    static func get_moviePopular(query: BaseQuery) -> BaseResult<MovieModel> {
        return BaseRouter.movies_Popular(query: query).object()
    }
    static func get_movieTopRate(query: BaseQuery) -> BaseResult<MovieModel> {
        return BaseRouter.movies_TopRate(query: query).object()
    }
    static func get_movieUpComing(query: BaseQuery) -> BaseResult<MovieModel> {
        return BaseRouter.movies_UpComing(query: query).object()
    }
    static func get_movieNowPlaying(query: BaseQuery) -> BaseResult<MovieModel> {
        return BaseRouter.movies_NowPlaing(query: query).object()
    }
    static func get_movieDetail(query: BaseQuery, id: Int) -> BaseResult<MovieModelData> {
        return BaseRouter.movies_Detail(query: query, id: id).object()
    }
}
