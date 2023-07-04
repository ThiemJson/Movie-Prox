//
//  MovieModel.swift
//  movie-buff
//
//  Created by Prox on 5/10/23.
//  Copyright © 2023 Prox. All rights reserved.
//

import Foundation
struct MovieModel: Codable, DefaultModel {
    var page            : Int?
    var totalResults    : Int?
    var totalPages      : Int?
    var results         : [MovieModelData] = []
    
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
        results         = try values.decodeIfPresent([MovieModelData].self, forKey: .results) ?? []
    }
    
    mutating func toJSON() -> [String: Any] {
        return self.convertObjectToJson()?.dictionaryObject ?? [:]
    }
}

// MARK: - MovieModelData
struct MovieModelData: Codable {
    var adult: Bool?
    var addWatchlistDate: String?
    var backdropPath: String?
    //var belongsToCollection: BelongsToCollection?
    //var budget: Int?
    var genres: [Genre] = []
    var genresID: [Int] = []
    //var homepage: String?
    var id: Int?
    //var imdbID: String?
    //var originalLanguage: OriginalLanguage?
    var originalTitle, overview: String?
    var popularity: Double?
    var posterPath: String?
    //var productionCompanies: [ProductionCompany] = []
    //var productionCountries: [ProductionCountry] = []
    var releaseDate: String?
    //var revenue,
    var runtime: Int?
    //var spokenLanguages: [SpokenLanguage] = []
    var status, tagline, title: String?
    var video: Bool?
    var voteAverage: Double?
    var voteCount: Int?
    var videos: Videos?
    var credits: Credits?
    var recommendations: Recommendations?
    //var reviews: Reviews?
    
    enum CodingKeys: String, CodingKey {
        case adult
        case addWatchlistDate
        case genresID = "genre_ids"
        case backdropPath = "backdrop_path"
        //case belongsToCollection = "belongs_to_collection"
        //case budget, homepage
        case id
        case genres
        //case imdbID = "imdb_id"
        //case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        //case productionCompanies = "production_companies"
        //case productionCountries = "production_countries"
        case releaseDate = "release_date"
        //case revenue,
        case runtime
        //case spokenLanguages = "spoken_languages"
        case status, tagline, title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case videos, credits
        case recommendations
        //case reviews
    }
    
    init(from decoder: Decoder) throws {
        let container           = try decoder.container(keyedBy: CodingKeys.self)
        adult                   = try? container.decodeIfPresent(Bool.self, forKey: .adult)
        backdropPath            = try? container.decodeIfPresent(String.self, forKey: .backdropPath)
        //belongsToCollection     = try? container.decodeIfPresent(BelongsToCollection.self, forKey: .belongsToCollection)
        //budget                  = try? container.decodeIfPresent(Int.self, forKey: .budget)
        genres                  = try container.decodeIfPresent([Genre].self, forKey: .genres) ?? []
        genresID                = try container.decodeIfPresent([Int].self, forKey: .genresID) ?? genres.map { $0.id ?? 0 } ?? []
        //homepage                = try? container.decodeIfPresent(String.self, forKey: .homepage)
        id                      = try? container.decodeIfPresent(Int.self, forKey: .id)
        //imdbID                  = try? container.decodeIfPresent(String.self, forKey: .imdbID)
        //originalLanguage        = try? container.decodeIfPresent(OriginalLanguage.self, forKey: .originalLanguage)
        originalTitle           = try? container.decodeIfPresent(String.self, forKey: .originalTitle)
        overview                = try? container.decodeIfPresent(String.self, forKey: .overview)
        popularity              = try? container.decodeIfPresent(Double.self, forKey: .popularity)
        posterPath              = try? container.decodeIfPresent(String.self, forKey: .posterPath)
        //productionCompanies     = try? container.decodeIfPresent([ProductionCompany].self, forKey: .productionCompanies) ?? []
        //productionCountries     = try? container.decodeIfPresent([ProductionCountry].self, forKey: .productionCountries) ?? []
        releaseDate             = try? container.decodeIfPresent(String.self, forKey: .releaseDate)
        //revenue                 = try? container.decodeIfPresent(Int.self, forKey: .revenue)
        runtime                 = try? container.decodeIfPresent(Int.self, forKey: .runtime)
        //spokenLanguages         = try? container.decode([SpokenLanguage].self, forKey: .spokenLanguages) ?? []
        status                  = try? container.decodeIfPresent(String.self, forKey: .status)
        //tagline                 = try? container.decodeIfPresent(String.self, forKey: .tagline)
        title                   = try? container.decodeIfPresent(String.self, forKey: .title)
        video                   = try? container.decodeIfPresent(Bool.self, forKey: .video)
        voteAverage             = try? container.decodeIfPresent(Double.self, forKey: .voteAverage)
        voteCount               = try? container.decodeIfPresent(Int.self, forKey: .voteCount)
        videos                  = try? container.decodeIfPresent(Videos.self, forKey: .videos)
        credits                 = try? container.decodeIfPresent(Credits.self, forKey: .credits)
        recommendations         = try? container.decodeIfPresent(Recommendations.self, forKey: .recommendations)
        addWatchlistDate        = try? container.decodeIfPresent(String.self, forKey: .addWatchlistDate)
        //reviews                 = try? container.decodeIfPresent(Reviews.self, forKey: .reviews)
    }
    
    init(){}
    
    mutating func toJSON() -> [String: Any] {
        return self.convertObjectToJson()?.dictionaryObject ?? [:]
    }
    
    static func from(data: WatchingSessionModel) -> MovieModelData {
        var movieModelData              = MovieModelData()
        movieModelData.id               = data.id
        movieModelData.backdropPath     = data.backdropPath
        movieModelData.title            = data.name
        movieModelData.voteAverage      = data.voteAvarage
        movieModelData.overview         = data.overview
        return movieModelData
    }
}

// MARK: - BelongsToCollection
struct BelongsToCollection: Codable {
    var id: Int?
    var name, posterPath, backdropPath: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }
}

// MARK: - Cast
struct Cast: Codable {
    var adult: Bool?
    var gender, id: Int?
    var knownForDepartment: String?
    var name, originalName: String?
    var popularity: Double?
    var profilePath: String?
    var castID: Int?
    var character: String?
    var creditID: String?
    var order: Int?
    var department: String?
    var job: String?
    
    enum CodingKeys: String, CodingKey {
        case adult, gender, id
        case knownForDepartment = "known_for_department"
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case castID = "cast_id"
        case character
        case creditID = "credit_id"
        case order, department, job
    }
    
    static func convertToPersonModalData(cast: Cast) -> PersonModelData {
        var person = PersonModelData()
        person.adult    = cast.adult
        person.id       = cast.id
        person.name     = cast.name
        person.profilePath  = cast.profilePath
        return person
    }
}

// MARK: - ProductionCompany
struct ProductionCompany: Codable {
    var id: Int?
    var logoPath, name, originCountry: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }
}

// MARK: - Reviews
struct Reviews: Codable {
    var page: Int?
    var results: [ReviewsResult] = []
    var totalPages, totalResults: Int?
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - ReviewsResult
struct ReviewsResult: Codable {
    var author: String?
    var authorDetails: AuthorDetails?
    var content, createdAt, id, updatedAt: String?
    var url: String?
    
    enum CodingKeys: String, CodingKey {
        case author
        case authorDetails = "author_details"
        case content
        case createdAt = "created_at"
        case id
        case updatedAt = "updated_at"
        case url
    }
}

// MARK: - AuthorDetails
struct AuthorDetails: Codable {
    var name, username: String?
    var avatarPath: String?
    var rating: Double?
    
    enum CodingKeys: String, CodingKey {
        case name, username
        case avatarPath = "avatar_path"
        case rating
    }
}
