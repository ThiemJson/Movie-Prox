//
//  MediaModel.swift
//  movie-buff
//
//  Created by Prox on 30/04/2023.
//  Copyright © 2023 Prox. All rights reserved.
//

import Foundation

/// Generate model by:  https://app.quicktype.io/
// MARK: - Movie
struct MediaModel: Codable, DefaultModel {
    var page            : Int?
    var totalResults    : Int?
    var totalPages      : Int?
    var results         : [MediaModelData] = []
    
    enum CodingKeys: String, CodingKey {
        case page           = "page"
        case totalPages     = "total_pages"
        case totalResults   = "total_results"
        case results        = "results"
    }
    
    init(from decoder: Decoder) throws {
        let values      = try decoder.container(keyedBy: CodingKeys.self)
        page            = try? values.decodeIfPresent(Int.self, forKey: .page)
        totalResults    = try? values.decodeIfPresent(Int.self, forKey: .totalResults)
        totalPages      = try? values.decodeIfPresent(Int.self, forKey: .totalPages)
        results         = try values.decodeIfPresent([MediaModelData].self, forKey: .results) ?? []
    }
    
    mutating func toJSON() -> [String: Any] {
        return self.convertObjectToJson()?.dictionaryObject ?? [:]
    }
}

enum MediaModelDataType : String {
    case movie  = "movie"
    case tvshow = "tv"
    case actor  = "person"
}

// MARK: - Result
struct MediaModelData: Codable {
    var genres          : [Genre] = []
    var genreIDS        : [Int] = []
    var adult           : Bool?
    var backdropPath    : String?
    var id              : Int?
    var originalTitle   : String?
    var voteAverage     : Double?
    var popularity      : Double?
    var posterPath      : String?
    var overview        : String?
    var title           : String?
    var name            : String?
    var originalName    : String?
    var profilePath     : String?
    var originalLanguage: String?
    var voteCount       : Int?
    var releaseDate     : String?
    var firstAirDate    : String?
    var video           : Bool?
    var mediaType       : String?
    var subtitle        : String?
    var knownForDepartment : String?
    var knowsFor        : [MediaModelData] = []
    
    enum CodingKeys: String, CodingKey {
        case adult
        case id
        case overview, title
        case popularity
        case video
        case subtitle
        case genreIDS           = "genre_ids"
        case backdropPath       = "backdrop_path"
        case originalTitle      = "original_title"
        case voteAverage        = "vote_average"
        case posterPath         = "poster_path"
        case originalLanguage   = "original_language"
        case voteCount          = "vote_count"
        case releaseDate        = "release_date"
        case firstAirDate       = "first_air_date"
        case mediaType          = "media_type"
        case name               = "name"
        case originalName       = "original_name"
        case profilePath        = "profile_path"
        case knownForDepartment = "known_for_department"
        case genres             = "genres"
    }
    
    init(){}
    
    init(from decoder: Decoder) throws {
        let values      = try decoder.container(keyedBy: CodingKeys.self)
        genres          = try values.decodeIfPresent([Genre].self, forKey: .genres) ?? []
        genreIDS        = try values.decodeIfPresent([Int].self, forKey: .genreIDS) ?? []
        adult           = try? values.decodeIfPresent(Bool.self, forKey: .adult)
        backdropPath    = try? values.decodeIfPresent(String.self, forKey: .backdropPath)
        id              = try? values.decodeIfPresent(Int.self, forKey: .id)
        originalTitle   = try? values.decodeIfPresent(String.self, forKey: .originalTitle)
        voteAverage     = try? values.decodeIfPresent(Double.self, forKey: .voteAverage)
        popularity      = try? values.decodeIfPresent(Double.self, forKey: .popularity)
        posterPath      = try? values.decodeIfPresent(String.self, forKey: .posterPath)
        overview        = try? values.decodeIfPresent(String.self, forKey: .overview)
        title           = try? values.decodeIfPresent(String.self, forKey: .title)
        originalLanguage = try? values.decodeIfPresent(String.self, forKey: .originalLanguage)
        voteCount       = try? values.decodeIfPresent(Int.self, forKey: .voteCount)
        releaseDate     = try? values.decodeIfPresent(String.self, forKey: .releaseDate)
        video           = try? values.decodeIfPresent(Bool.self, forKey: .video)
        firstAirDate    = try? values.decodeIfPresent(String.self, forKey: .firstAirDate)
        mediaType       = try? values.decodeIfPresent(String.self, forKey: .mediaType)
        name            = try? values.decodeIfPresent(String.self, forKey: .name)
        originalName    = try? values.decodeIfPresent(String.self, forKey: .originalName)
        profilePath     = try? values.decodeIfPresent(String.self, forKey: .profilePath)
        subtitle        = try? values.decodeIfPresent(String.self, forKey: .subtitle)
        knownForDepartment = try? values.decodeIfPresent(String.self, forKey: .knownForDepartment)
        //knowsFor        = try? values.decodeIfPresent([MediaModel].self, forKey: .genreIDS) ?? []
    }
    
    mutating func toJSON() -> [String: Any] {
        return self.convertObjectToJson()?.dictionaryObject ?? [:]
    }
    
    mutating func setMediaType(type: Int) {
        //        let mapper  = [ SearchType.Movie : MediaModelDataType.movie.rawValue,
        //                        SearchType.TVShow : MediaModelDataType.tvshow.rawValue,
        //                        SearchType.Actor : MediaModelDataType.actor.rawValue]
        //        self.mediaType = mapper[type]
    }
    
    static func from(person: PersonModelData) -> MediaModelData {
        var mediaModel              = MediaModelData()
        mediaModel.adult            = person.adult
        mediaModel.profilePath      = person.profilePath
        mediaModel.id               = person.id
        mediaModel.name             = person.name
        mediaModel.popularity       = person.popularity
        mediaModel.mediaType        = "person"
        return mediaModel
    }
    
    static func from(movie: MovieModelData) -> MediaModelData {
        var mediaModel              = MediaModelData()
        mediaModel.genres           = movie.genres
        mediaModel.genreIDS         = movie.genresID
        mediaModel.adult            = movie.adult
        mediaModel.backdropPath     = movie.backdropPath
        mediaModel.id               = movie.id
        mediaModel.originalTitle    = movie.originalTitle
        mediaModel.voteAverage      = movie.voteAverage
        mediaModel.popularity       = movie.popularity
        mediaModel.posterPath       = movie.posterPath
        mediaModel.overview         = movie.overview
        mediaModel.title            = movie.title
        mediaModel.voteCount        = movie.voteCount
        mediaModel.releaseDate      = movie.releaseDate
        mediaModel.video            = movie.video
        mediaModel.mediaType        = "movie"
        return mediaModel
    }
    
    static func from(tvShow: TVShowModelData) -> MediaModelData {
        var mediaModel              = MediaModelData()
        mediaModel.genres           = tvShow.genres
        mediaModel.genreIDS         = tvShow.genresID
        mediaModel.adult            = tvShow.adult
        mediaModel.backdropPath     = tvShow.backdropPath
        mediaModel.id               = tvShow.id
        mediaModel.originalName     = tvShow.originalName
        mediaModel.voteAverage      = tvShow.voteAverage
        mediaModel.popularity       = tvShow.popularity
        mediaModel.posterPath       = tvShow.posterPath
        mediaModel.overview         = tvShow.overview
        mediaModel.name             = tvShow.name
        mediaModel.voteCount        = tvShow.voteCount
        mediaModel.firstAirDate     = tvShow.firstAirDate
        mediaModel.mediaType        = "tv"
        return mediaModel
    }
    
    static func toMovie(mediaModel: MediaModelData) -> MovieModelData {
        var movieModel              = MovieModelData()
        movieModel.genres           = mediaModel.genres
        movieModel.genresID         = mediaModel.genreIDS
        movieModel.adult            = mediaModel.adult
        movieModel.backdropPath     = mediaModel.backdropPath
        movieModel.id               = mediaModel.id
        movieModel.originalTitle    = mediaModel.originalTitle
        movieModel.voteAverage      = mediaModel.voteAverage
        movieModel.popularity       = mediaModel.popularity
        movieModel.posterPath       = mediaModel.posterPath
        movieModel.overview         = mediaModel.overview
        movieModel.title            = mediaModel.title
        movieModel.voteCount        = mediaModel.voteCount
        movieModel.releaseDate      = mediaModel.releaseDate
        movieModel.video            = mediaModel.video
        return movieModel
    }
    
    static func toTVShow(mediaModel: MediaModelData) -> TVShowModelData {
        var tvshowModel              = TVShowModelData()
        tvshowModel.genres           = mediaModel.genres
        tvshowModel.genresID         = mediaModel.genreIDS
        tvshowModel.adult            = mediaModel.adult
        tvshowModel.backdropPath     = mediaModel.backdropPath
        tvshowModel.id               = mediaModel.id
        tvshowModel.originalName     = mediaModel.originalName
        tvshowModel.voteAverage      = mediaModel.voteAverage
        tvshowModel.popularity       = mediaModel.popularity
        tvshowModel.posterPath       = mediaModel.posterPath
        tvshowModel.overview         = mediaModel.overview
        tvshowModel.name             = mediaModel.name
        tvshowModel.voteCount        = mediaModel.voteCount
        tvshowModel.firstAirDate     = mediaModel.firstAirDate
        return tvshowModel
    }
    
    static func toPerson(mediaModel: MediaModelData) -> PersonModelData {
        var personModel             = PersonModelData()
        personModel.adult           = mediaModel.adult
        personModel.profilePath     = mediaModel.profilePath
        personModel.id              = mediaModel.id
        personModel.name            = mediaModel.name
        personModel.popularity      = mediaModel.popularity
        return personModel
    }
}
