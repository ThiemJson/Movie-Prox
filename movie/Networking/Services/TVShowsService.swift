//
//  TVShowsService.swift
//  movie-buff
//
//  Created by Prox on 08/05/2023.
//  Copyright © 2023 Prox. All rights reserved.
//

import Foundation
public class TVShowsService {
    static func get_tvByGenres(query: BaseQuery) -> BaseResult<TVShowModel> {
        return BaseRouter.genres_discover_tv(query: query).object()
    }
    static func get_tvEpisodeDetail(idTV: Int, idSeason: Int, idEpisode: Int, query: BaseQuery) -> BaseResult<EpisodeModelData> {
        return BaseRouter.tv_EpisodeDetail(idTv: idTV, idSeason: idSeason, idEpisode: idEpisode, query: query).object()
    }
    static func get_tvSeason(idTV: Int, idSeason: Int, query: BaseQuery) -> BaseResult<Season> {
        return BaseRouter.tv_Episode(idTv: idTV, idSeason: idSeason, query: query).object()
    }
    static func get_tvTopRate(query: BaseQuery) -> BaseResult<TVShowModel> {
        return BaseRouter.tv_TopRate(query: query).object()
    }
    static func get_tvPopular(query: BaseQuery) -> BaseResult<TVShowModel> {
        return BaseRouter.tv_Popular(query: query).object()
    }
    static func get_tvAiringToday(query: BaseQuery) -> BaseResult<TVShowModel> {
        return BaseRouter.tv_AiringToday(query: query).object()
    }
    static func get_tvDetail(query: BaseQuery, id: Int) -> BaseResult<TVShowModelData> {
        return BaseRouter.tv_Detail(query: query, id: id).object()
    }
}
