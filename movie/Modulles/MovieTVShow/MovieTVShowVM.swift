//
//  MovieTVShowVM.swift
//  movie
//
//  Created by ThiemJason on 05/07/2023.
//

import Foundation
import RxCocoa
import RxSwift

/** `Define` */
protocol MovieTVShowVM : BaseViewModel {
    /** `MOVIE` */
    var rx_Movies_Playing : BehaviorRelay<MovieModel?> { get }
    var rx_Movies_TopRate : BehaviorRelay<MovieModel?> { get }
    var rx_Movies_Popular : BehaviorRelay<MovieModel?> { get }
    
    /** `TV_SHOW` */
    var rx_TVShow_Playing : BehaviorRelay<TVShowModel?> { get }
    var rx_TVShow_TopRate : BehaviorRelay<TVShowModel?> { get }
    var rx_TVShow_Popular : BehaviorRelay<TVShowModel?> { get }
    
    /** `Actor` */
    var rx_Actor        : BehaviorRelay<PersonModel?> { get }
    
    /** `Genre` */
    var rx_Genre        : BehaviorRelay<GenresModel?> { get }
    
    /** `Error` */
    var rxError     : BehaviorRelay<BaseResponse?> { get }
    
    /** `Movie` */
    func getMovieNewPlaying(query: BaseQuery)
    func getMovieTopRated(query: BaseQuery)
    func getMoviePopular(query: BaseQuery)
    
    /** `TVShow` */
    func getTVAiringToday(query: BaseQuery)
    func getTVTopRated(query: BaseQuery)
    func getTVPopular(query: BaseQuery)
    
    /** `Genres` */
    func getGenresMovie(query: BaseQuery, completion: @escaping ((_: GenresModel) -> Void))
    func getGenresTV(query: BaseQuery, completion: @escaping ((_: GenresModel) -> Void))
    
    /** `Actor` */
    func getActorPopular(query: BaseQuery)
}

/** `Implement function` */
extension MovieTVShowVM {
    func getMoviePopular(query: BaseQuery) {
        MoviesService.get_moviePopular(query: query)
            .onSuccess { response in self.rx_Movies_Popular.accept(response) }
            .onError { error in self.rxError.accept(error) }
    }
    
    func getMovieTopRated(query: BaseQuery) {
        MoviesService.get_movieTopRate(query: query)
            .onSuccess { response in self.rx_Movies_TopRate.accept(response) }
            .onError { error in self.rxError.accept(error) }
    }
    
    func getMovieNewPlaying(query: BaseQuery) {
        MoviesService.get_movieNowPlaying(query: query)
            .onSuccess { response in
                self.rx_Movies_Playing.accept(response)
            }
            .onError { error in
                print("error ===> \(error.json)")
                self.rxError.accept(error) }
    }
    
    func getTVAiringToday(query: BaseQuery) {
        TVShowsService.get_tvAiringToday(query: query)
            .onSuccess { response in self.rx_TVShow_Playing.accept(response) }
            .onError { error in self.rxError.accept(error) }
    }
    
    func getTVTopRated(query: BaseQuery) {
        TVShowsService.get_tvTopRate(query: query)
            .onSuccess { response in self.rx_TVShow_TopRate.accept(response) }
            .onError { error in self.rxError.accept(error) }
    }
    
    func getTVPopular(query: BaseQuery) {
        TVShowsService.get_tvPopular(query: query)
            .onSuccess { response in self.rx_TVShow_Popular.accept(response) }
            .onError { error in self.rxError.accept(error) }
    }
    
    func getGenresMovie(query: BaseQuery, completion: @escaping ((_: GenresModel) -> Void) = { _ in } ) {
        GenresService.get_genresMovie(query: query)
            .onSuccess { response in
                completion(response)
                self.rx_Genre.accept(response)
            }
            .onError { error in self.rxError.accept(error) }
    }
    
    func getGenresTV(query: BaseQuery, completion: @escaping ((_: GenresModel) -> Void) = { _ in } ) {
        GenresService.get_genresTv(query: query)
            .onSuccess { response in
                completion(response)
                self.rx_Genre.accept(response)
            }
            .onError { error in self.rxError.accept(error) }
    }
    
    func getActorPopular(query: BaseQuery) {
        ActorService.get_actorPopular(query: query)
            .onSuccess { response in self.rx_Actor.accept(response) }
            .onError { error in self.rxError.accept(error) }
    }
}

/** `Implement Properties` */
class MovieTVShowVMObject : BaseViewModelObject, MovieTVShowVM {
    var rxError             = BehaviorRelay<BaseResponse?>.init(value: nil)
    
    var rx_Movies_Playing   = BehaviorRelay<MovieModel?>.init(value: nil)
    
    var rx_Movies_TopRate   = BehaviorRelay<MovieModel?>.init(value: nil)
    
    var rx_Movies_Popular   = BehaviorRelay<MovieModel?>.init(value: nil)
    
    var rx_TVShow_Playing   = BehaviorRelay<TVShowModel?>.init(value: nil)
    
    var rx_TVShow_TopRate   = BehaviorRelay<TVShowModel?>.init(value: nil)
    
    var rx_TVShow_Popular   = BehaviorRelay<TVShowModel?>.init(value: nil)
    
    var rx_Actor            = BehaviorRelay<PersonModel?>.init(value: nil)
    
    var rx_Genre            = BehaviorRelay<GenresModel?>.init(value: nil)
}

