//
//  PersonModel.swift
//  movie-buff
//
//  Created by Prox on 5/10/23.
//  Copyright © 2023 Prox. All rights reserved.
//

import Foundation
struct PersonModel: Codable, DefaultModel {
    var page            : Int?
    var totalResults    : Int?
    var totalPages      : Int?
    var results         : [PersonModelData] = []
    
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
        results         = try values.decodeIfPresent([PersonModelData].self, forKey: .results) ?? []
    }
    
    mutating func toJSON() -> [String: Any] {
        return self.convertObjectToJson()?.dictionaryObject ?? [:]
    }
}

// MARK: - PersonModelData
struct PersonModelData: Codable {
    var adult: Bool?
    var biography, birthday: String?
    var deathday: String?
    var gender: Int?
    var homepage: String?
    var id: Int?
    var imdbID, knownForDepartment, name, placeOfBirth: String?
    var popularity: Double?
    var profilePath: String?
    var movieCredits: MovieCredits?
    var images: ImagesProfile?
    var tvCredits: TvCredits?
    
    enum CodingKeys: String, CodingKey {
        case adult
        case biography, birthday, deathday, gender, homepage, id
        case imdbID = "imdb_id"
        case knownForDepartment = "known_for_department"
        case name
        case placeOfBirth = "place_of_birth"
        case popularity
        case profilePath = "profile_path"
        case movieCredits = "movie_credits"
        case images
        case tvCredits = "tv_credits"
    }
    
    init(){}
}

// MARK: - Profile
struct Profile: Codable {
    var aspectRatio: Double?
    var height: Int?
    var iso639_1: String?
    var filePath: String?
    var voteAverage: Double?
    var voteCount, width: Int?
    var isAds: Bool?
    
    enum CodingKeys: String, CodingKey {
        case aspectRatio = "aspect_ratio"
        case height
        case iso639_1 = "iso_639_1"
        case filePath = "file_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case width
    }
}

struct ImagesProfile: Codable {
    var profiles: [Profile] = []
}

// MARK: - MovieCredits
struct MovieCredits: Codable {
    var cast : [CrewElement] = []
    var crew : [CrewElement] = []
    enum CodingKeys: String, CodingKey {
        case cast
        case crew
    }
    init(from decoder: Decoder) throws {
        let values      = try decoder.container(keyedBy: CodingKeys.self)
        cast            = try values.decodeIfPresent([CrewElement].self, forKey: .cast) ?? []
        crew            = try values.decodeIfPresent([CrewElement].self, forKey: .crew) ?? []
    }
}

// MARK: - CrewElement
struct CrewElement: Codable {
    var adult: Bool?
    var backdropPath: String?
    var genreIDS: [Int] = []
    var id: Int?
    var originalTitle, overview: String?
    var popularity: Double?
    var posterPath: String?
    var releaseDate, title: String?
    var video: Bool?
    var voteAverage: Double?
    var voteCount: Int?
    var character: String?
    var creditID: String?
    var order: Int?
    var department, job: String?
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case character
        case creditID = "credit_id"
        case order, department, job
    }
    init(from decoder: Decoder) throws {
        let values      = try decoder.container(keyedBy: CodingKeys.self)
        adult           = try? values.decodeIfPresent(Bool.self, forKey: .adult)
        backdropPath    = try? values.decodeIfPresent(String.self, forKey: .backdropPath)
        genreIDS        = try values.decodeIfPresent([Int].self, forKey: .genreIDS) ?? []
        id              = try? values.decodeIfPresent(Int.self, forKey: .id)
        originalTitle   = try? values.decodeIfPresent(String.self, forKey: .originalTitle)
        overview        = try? values.decodeIfPresent(String.self, forKey: .overview)
        posterPath      = try? values.decodeIfPresent(String.self, forKey: .posterPath)
        releaseDate     = try? values.decodeIfPresent(String.self, forKey: .releaseDate)
        title           = try? values.decodeIfPresent(String.self, forKey: .title)
        character       = try? values.decodeIfPresent(String.self, forKey: .character)
        creditID        = try? values.decodeIfPresent(String.self, forKey: .creditID)
        department      = try? values.decodeIfPresent(String.self, forKey: .department)
        job             = try? values.decodeIfPresent(String.self, forKey: .job)
        popularity      = try? values.decodeIfPresent(Double.self, forKey: .popularity)
        video           = try? values.decodeIfPresent(Bool.self, forKey: .video)
        voteAverage     = try? values.decodeIfPresent(Double.self, forKey: .voteAverage)
        voteCount       = try? values.decodeIfPresent(Int.self, forKey: .voteCount)
        order           = try? values.decodeIfPresent(Int.self, forKey: .order)
    }
    
    static func convertToRecommentDation( data: CrewElement ) -> RecommendationsResult {
        var recommendation              = RecommendationsResult()
        recommendation.id               = data.id
        recommendation.genreIDS         = data.genreIDS
        recommendation.backdropPath     = data.backdropPath
        recommendation.originalName     = data.originalTitle
        recommendation.overview         = data.overview
        recommendation.title            = data.title
        recommendation.posterPath       = data.posterPath
        recommendation.voteAverage      = data.voteAverage
        recommendation.voteCount        = data.voteCount
        recommendation.popularity       = data.popularity
        recommendation.releaseDate     = data.releaseDate
        recommendation.mediaType        = "movie"
        return recommendation
    }
}

// MARK: - TvCredits
struct TvCredits: Codable {
    var cast: [TvCreditsCast] = []
    enum CodingKeys: String, CodingKey {
        case cast
    }
    init(from decoder: Decoder) throws {
        let values      = try decoder.container(keyedBy: CodingKeys.self)
        cast            = try values.decodeIfPresent([TvCreditsCast].self, forKey: .cast) ?? []
    }
}

// MARK: - TvCreditsCast
struct TvCreditsCast: Codable {
    var adult: Bool?
    var backdropPath: String?
    var genreIDS: [Int] = []
    var id: Int?
    var originalName, overview: String?
    var popularity: Double?
    var posterPath, firstAirDate, name: String?
    var voteAverage: Double?
    var voteCount: Int?
    var character, creditID: String?
    var episodeCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalName = "original_name"
        case overview, popularity
        case posterPath = "poster_path"
        case firstAirDate = "first_air_date"
        case name
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case character
        case creditID = "credit_id"
        case episodeCount = "episode_count"
    }
    
    static func convertToRecommentDation( data: TvCreditsCast ) -> RecommendationsResult {
        var recommendation              = RecommendationsResult()
        recommendation.id               = data.id
        recommendation.backdropPath     = data.backdropPath
        recommendation.originalName     = data.originalName
        recommendation.overview         = data.overview
        recommendation.genreIDS         = data.genreIDS
        recommendation.name             = data.name
        recommendation.posterPath       = data.posterPath
        recommendation.voteAverage      = data.voteAverage
        recommendation.voteCount        = data.voteCount
        recommendation.popularity       = data.popularity
        recommendation.firstAirDate     = data.firstAirDate
        recommendation.mediaType        = "tv"
        return recommendation
    }
}
