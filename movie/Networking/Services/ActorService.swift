//
//  ActorService.swift
//  movie-buff
//
//  Created by Prox on 08/05/2023.
//  Copyright © 2023 Prox. All rights reserved.
//

import Foundation
public class ActorService {
    static func get_actorPopular(query: BaseQuery) -> BaseResult<PersonModel> {
        return BaseRouter.actor_Popular(query: query).object()
    }
    static func get_actorDetail(id: Int, query: BaseQuery) -> BaseResult<PersonModelData> {
        return BaseRouter.actor_Detail(query: query, id: id).object()
    }
}
