//
//  OHRouter.swift
//  movie
//
//  Created by Prox on 24/03/2023.
//  Copyright © 2023 Prox. All rights reserved.
//

import Alamofire

enum BaseEndpoint : String {
    /** `Auth` */
    case register   = "/authaccount/registration"
    case login      = "/authaccount/login"
    /** `User` */
    case user       = "/users"
    
    /** `Search` */
    case search_multi   = "/search/multi"
    case search_movie   = "/search/movie"
    case search_tvshow  = "/search/tv"
    case search_person  = "/search/person"
    
    /** `Genres` */
    case genres_movie   = "/genre/movie/list"
    case genres_tvshow  = "/genre/tv/list"
    
    /** `Movies` */
    case movies_now_playing = "/movie/now_playing"
    case movies_top_rated   = "/movie/top_rated"
    case movies_popular     = "/movie/popular"
    case movies_upcoming    = "/movie/upcoming"
    case movies_genres_id   = "/discover/movie"
    case movies_detail      = "/movie"
    
    /** `TV Shows` */
    case tv_airing_today    = "/tv/airing_today"
    case tv_popular         = "/tv/popular"
    case tv_genres_id       = "/discover/tv"
    case tv_top_rated       = "/tv/top_rated"
    case tv_detail          = "/tv"
    case tv_episode         = "/tv/100/season"
    
    /** `Actors` */
    case actor_popular      = "/person/popular"
    case actor_detail       = "/person"
}

enum BaseRouter {
#if Develop
    static let domain       = "api.themoviedb.org/3"
    static let img_domain   = "image.tmdb.org/t/p"
    static let api_key      = "dc9e9a73378330417bb4818abf1b60ed"
    
    static let baseURL      = "https://\(domain)"
    static let baseImgURL   = "https://\(img_domain)"
#elseif Staging
    static let domain       = "api.themoviedb.org/3"
    static let img_domain   = "image.tmdb.org/t/p"
    static let api_key      = "dc9e9a73378330417bb4818abf1b60ed"
    
    static let baseURL      = "https://\(domain)"
    static let baseImgURL   = "https://\(img_domain)"
#else
    static let domain       = "api.themoviedb.org/3"
    static let img_domain   = "image.tmdb.org/t/p"
    static let api_key      = "dc9e9a73378330417bb4818abf1b60ed"
    
    static let baseURL      = "https://\(domain)"
    static let baseImgURL   = "https://\(img_domain)"
#endif
    
    /** `Auth` */
    case register(regisModel: BaseRegistrationModel)
    case login(loginModel: BaseLoginModel)
    
    /** `Seach` */
    case searchMovies(query: BaseQuery)
    case searchTVShows(query: BaseQuery)
    case searchPerson(query: BaseQuery)
    case searchMulti(query: BaseQuery)
    
    /** `Movies` */
    case movies_NowPlaing(query: BaseQuery)
    case movies_TopRate(query: BaseQuery)
    case movies_Detail(query: BaseQuery, id: Int)
    case movies_Popular(query: BaseQuery)
    case movies_UpComing(query: BaseQuery)
    
    /** `TV Shows` */
    case tv_AiringToday(query: BaseQuery)
    case tv_Popular(query: BaseQuery)
    case tv_TopRate(query: BaseQuery)
    case tv_Detail(query: BaseQuery, id: Int)
    case tv_Episode(idTv: Int, idSeason: Int, query: BaseQuery)
    case tv_EpisodeDetail(idTv: Int, idSeason: Int, idEpisode: Int, query: BaseQuery)
    
    /** `Actors` */
    case actor_Popular(query: BaseQuery)
    case actor_Detail(query: BaseQuery, id: Int)
    
    /** `Genres` */
    case genres_tv(query: BaseQuery)
    case genres_movie(query: BaseQuery)
    case genres_discover_movie(query: BaseQuery)
    case genres_discover_tv(query: BaseQuery)
}

extension BaseRouter: URLRequestConvertible {
    // MARK: - Request Info
    var request: (HTTPMethod, String) {
        switch self {
            /** `Auth` */
        case .register(regisModel: _):
            return (.post, BaseEndpoint.register.rawValue)
        case .login(loginModel: _):
            return (.post, BaseEndpoint.login.rawValue)
            
            /** `Search` */
        case .searchMovies(query: _):
            return (.get, BaseEndpoint.search_movie.rawValue)
        case .searchTVShows(query: _):
            return (.get, BaseEndpoint.search_tvshow.rawValue)
        case .searchPerson(query: _):
            return (.get, BaseEndpoint.search_person.rawValue)
        case .searchMulti(query: _):
            return (.get, BaseEndpoint.search_multi.rawValue)
            
            /** `Genres` */
        case .genres_tv(query: _):
            return (.get, BaseEndpoint.genres_tvshow.rawValue)
        case .genres_movie(query: _):
            return (.get, BaseEndpoint.genres_movie.rawValue)
        case .genres_discover_tv(query: _):
            return (.get, BaseEndpoint.tv_genres_id.rawValue)
        case .genres_discover_movie(query: _):
            return (.get, BaseEndpoint.movies_genres_id.rawValue)
            
            /** `Movies` */
        case .movies_NowPlaing(query: _):
            return (.get, BaseEndpoint.movies_now_playing.rawValue)
        case .movies_TopRate(query: _):
            return (.get, BaseEndpoint.movies_top_rated.rawValue)
        case .movies_Detail(query: _, id: let id):
            return (.get, BaseEndpoint.movies_detail.rawValue + "/\(id)")
        case .movies_Popular(query: _):
            return (.get, BaseEndpoint.movies_popular.rawValue)
        case .movies_UpComing(query: _):
            return (.get, BaseEndpoint.movies_upcoming.rawValue)
            
            /** `TVShows` */
        case .tv_AiringToday(query: _):
            return (.get, BaseEndpoint.tv_airing_today.rawValue)
        case .tv_Popular(query: _):
            return (.get, BaseEndpoint.tv_popular.rawValue)
        case .tv_TopRate(query: _):
            return (.get, BaseEndpoint.tv_top_rated.rawValue)
        case .tv_Detail(query: _, id: let id):
            return (.get, BaseEndpoint.tv_detail.rawValue + "/\(id)")
        case .tv_Episode(idTv: let idTv, idSeason: let idSeason, query: _):
            return (.get, BaseEndpoint.tv_detail.rawValue + "/\(idTv)" + "/season/\(idSeason)")
        case .tv_EpisodeDetail(idTv: let idTv, idSeason: let idSeason, idEpisode: let idEpisode, query: _):
            return (.get, BaseEndpoint.tv_detail.rawValue + "/\(idTv)" + "/season/\(idSeason)" + "/episode/\(idEpisode)")
            
            /** `Actor` */
        case .actor_Popular(query: _):
            return (.get, BaseEndpoint.actor_popular.rawValue)
        case .actor_Detail(query: _, id: let id):
            return (.get, BaseEndpoint.actor_detail.rawValue + "/\(id)")
        }
    }
    
    //MARK: - Request Params
    /**
     ******************************************************************
     * Config Query & Body
     ******************************************************************
     */
    var params: [String: Any]? {
        switch self {
            /** `Auth` */
        case .register(regisModel: var regisModel):
            return regisModel.toJSON()
        case .login(loginModel: var loginModel):
            return loginModel.toJSON()
            
            /** `Search` */
        case .searchMovies(query: var query):
            return query.toJSON()
        case .searchTVShows(query: var query):
            return query.toJSON()
        case .searchPerson(query: var query):
            return query.toJSON()
        case .searchMulti(query: var query):
            return query.toJSON()
            
            /** `Movies` */
        case .movies_Detail(query: var query, id: _):
            return query.toJSON()
        case .movies_NowPlaing(query: var query):
            return query.toJSON()
        case .movies_TopRate(query: var query):
            return query.toJSON()
        case .movies_Popular(query: var query):
            return query.toJSON()
        case .movies_UpComing(query: var query):
            return query.toJSON()
            
            /** `TV Shows` */
        case .tv_Detail(query: var query, id: _):
            return query.toJSON()
        case .tv_AiringToday(query: var query):
            return query.toJSON()
        case .tv_Popular(query: var query):
            return query.toJSON()
        case .tv_TopRate(query: var query):
            return query.toJSON()
        case .tv_Episode(idTv: _, idSeason: _, query: var query):
            return query.toJSON()
        case .tv_EpisodeDetail(idTv: _, idSeason: _, idEpisode: _, query: var query):
            return query.toJSON()
            
            /** `Actors` */
        case .actor_Popular(query: var query):
            return query.toJSON()
        case .actor_Detail(query: var query, id: _):
            return query.toJSON()
            
            /** `Genres` */
        case .genres_tv(query: var query):
            return query.toJSON()
        case .genres_movie(query: var query):
            return query.toJSON()
        case .genres_discover_tv(query: var query):
            return query.toJSON()
        case .genres_discover_movie(query: var query):
            return query.toJSON()
            
        default:
            return [:]
        }
    }
}

// MARK: - Request Define
extension BaseRouter {
    func asURLRequest() throws -> URLRequest {
        let url = try BaseRouter.baseURL.asURL()
        let method = request.0
        let path = request.1
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        let jsonEncodingMethods: [HTTPMethod] = [.post, .put, .delete, .patch]
        let encoding: ParameterEncoding = jsonEncodingMethods.contains(method) ? JSONEncoding.default : URLEncoding.queryString
        urlRequest = try encoding.encode(urlRequest, with: params)
        return urlRequest
    }
}
