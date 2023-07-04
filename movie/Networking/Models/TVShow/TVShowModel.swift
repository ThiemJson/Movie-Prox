//
//  TVShowModel.swift
//  movie-buff
//
//  Created by Prox on 5/10/23.
//  Copyright © 2023 Prox. All rights reserved.
//

import Foundation
// MARK: - Movie
struct TVShowModel: Codable, DefaultModel {
    var page            : Int?
    var totalResults    : Int?
    var totalPages      : Int?
    var results         : [TVShowModelData] = []
    
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
        results         = try values.decodeIfPresent([TVShowModelData].self, forKey: .results) ?? []
    }
    
    mutating func toJSON() -> [String: Any] {
        return self.convertObjectToJson()?.dictionaryObject ?? [:]
    }
}

// MARK: - TVShowModelData
struct TVShowModelData: Codable {
    var adult: Bool?
    var backdropPath: String?
    var genresID: [Int] = []
    var episodeRunTime: [Int] = []
    var firstAirDate: String?
    var genres: [Genre] = []
    var homepage: String?
    var id: Int?
    //var inProduction: Bool?
    //var languages: [OriginalLanguage] = []
    //var lastAirDate: String?
    //var lastEpisodeToAir: TEpisodeToAir?
    var name: String?
    //var nextEpisodeToAir: TEpisodeToAir?
    //var networks: [Network] = []
    var numberOfEpisodes, numberOfSeasons: Int?
    //var originCountry: [OriginCountry]
    //var originalLanguage: OriginalLanguage
    var originalName, overview: String?
    var popularity: Double?
    var posterPath: String?
    //var productionCompanies: [Network]
    //var productionCountries: [ProductionCountry]
    var seasons: [Season] = []
    //var spokenLanguages: [SpokenLanguage]
    var status, tagline, type: String?
    var voteAverage: Double?
    var voteCount: Int?
    var videos: Videos?
    var credits: Credits?
    var recommendations: Recommendations?
    //var images: Images?
    var addWatchlistDate: String?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case episodeRunTime = "episode_run_time"
        case genresID = "genre_ids"
        case firstAirDate = "first_air_date"
        case genres
        case homepage, id
        //case inProduction = "in_production"
        //case languages
        //case lastAirDate = "last_air_date"
        //case lastEpisodeToAir = "last_episode_to_air"
        case name
        //case nextEpisodeToAir = "next_episode_to_air"
        //case networks
        case numberOfEpisodes = "number_of_episodes"
        case numberOfSeasons = "number_of_seasons"
        //case originCountry = "origin_country"
        //case originalLanguage = "original_language"
        case originalName = "original_name"
        case overview, popularity
        case posterPath = "poster_path"
        //case productionCompanies = "production_companies"
        //case productionCountries = "production_countries"
        case seasons
        //case spokenLanguages = "spoken_languages"
        case status, tagline, type
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case credits
        case videos
        case recommendations
        case addWatchlistDate
        //case images
    }
    
    init(){}
    
    init(from decoder: Decoder) throws {
        let container           = try decoder.container(keyedBy: CodingKeys.self)
        adult                   = try? container.decodeIfPresent(Bool.self, forKey: .adult)
        type                    = try? container.decodeIfPresent(String.self, forKey: .type)
        episodeRunTime          = try container.decodeIfPresent([Int].self, forKey: .episodeRunTime) ?? []
        backdropPath            = try? container.decodeIfPresent(String.self, forKey: .backdropPath)
        firstAirDate            = try? container.decodeIfPresent(String.self, forKey: .firstAirDate)
        name                    = try? container.decodeIfPresent(String.self, forKey: .name)
        originalName            = try? container.decodeIfPresent(String.self, forKey: .originalName)
        //belongsToCollection     = try? container.decodeIfPresent(BelongsToCollection.self, forKey: .belongsToCollection)
        //budget                  = try? container.decodeIfPresent(Int.self, forKey: .budget)
        genres                  = try container.decodeIfPresent([Genre].self, forKey: .genres) ?? []
        genresID                = try container.decodeIfPresent([Int].self, forKey: .genresID) ?? genres.map { $0.id ?? 0 }
        homepage                = try? container.decodeIfPresent(String.self, forKey: .homepage)
        id                      = try? container.decodeIfPresent(Int.self, forKey: .id)
        numberOfSeasons         = try? container.decodeIfPresent(Int.self, forKey: .numberOfSeasons)
        numberOfEpisodes        = try? container.decodeIfPresent(Int.self, forKey: .numberOfEpisodes)
        seasons                 = try container.decodeIfPresent([Season].self, forKey: .seasons) ?? []
        //imdbID                  = try? container.decodeIfPresent(String.self, forKey: .imdbID)
        //originalLanguage        = try? container.decodeIfPresent(OriginalLanguage.self, forKey: .originalLanguage)
        overview                = try? container.decodeIfPresent(String.self, forKey: .overview)
        popularity              = try? container.decodeIfPresent(Double.self, forKey: .popularity)
        posterPath              = try? container.decodeIfPresent(String.self, forKey: .posterPath)
        //productionCompanies     = try? container.decodeIfPresent([ProductionCompany].self, forKey: .productionCompanies) ?? []
        //productionCountries     = try? container.decodeIfPresent([ProductionCountry].self, forKey: .productionCountries) ?? []
        //revenue                 = try? container.decodeIfPresent(Int.self, forKey: .revenue)
        //runtime                 = try? container.decodeIfPresent(Int.self, forKey: .runtime)
        //spokenLanguages         = try? container.decode([SpokenLanguage].self, forKey: .spokenLanguages) ?? []
        status                  = try? container.decodeIfPresent(String.self, forKey: .status)
        //tagline                 = try? container.decodeIfPresent(String.self, forKey: .tagline)
        voteAverage             = try? container.decodeIfPresent(Double.self, forKey: .voteAverage)
        voteCount               = try? container.decodeIfPresent(Int.self, forKey: .voteCount)
        credits                 = try? container.decodeIfPresent(Credits.self, forKey: .credits)
        recommendations         = try? container.decodeIfPresent(Recommendations.self, forKey: .recommendations)
        videos                  = try? container.decodeIfPresent(Videos.self, forKey: .videos)
        addWatchlistDate        = try? container.decodeIfPresent(String.self, forKey: .addWatchlistDate)
        //reviews                 = try? container.decodeIfPresent(Reviews.self, forKey: .reviews)
    }
    
    static func from(data: WatchingSessionModel) -> TVShowModelData {
        var movieModelData              = TVShowModelData()
        movieModelData.id               = data.id
        movieModelData.backdropPath     = data.backdropPath
        movieModelData.name             = data.name
        movieModelData.voteAverage      = data.voteAvarage
        movieModelData.overview         = data.overview
        return movieModelData
    }
}

// MARK: - Credits
struct Credits: Codable {
    let cast, crew: [Cast]
}



// MARK: - Images
//struct Images: Codable {
//    var backdrops, logos, posters: [Backdrop] = []
//}

// MARK: - Backdrop
struct Backdrop: Codable {
    var aspectRatio: Double
    var height: Int
    var iso639_1: String?
    var filePath: String
    var voteAverage: Double
    var voteCount, width: Int

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

enum OriginalLanguage: String, Codable {
    case en = "en"
    case ja = "ja"
}

// MARK: - TEpisodeToAir
struct TEpisodeToAir: Codable {
    var id: Int?
    var name, overview: String?
    var voteAverage, voteCount: Int?
    var airDate: String?
    var episodeNumber: Int?
    var productionCode: String?
    var runtime, seasonNumber, showID: Int?
    var stillPath: String?

    enum CodingKeys: String, CodingKey {
        case id, name, overview
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case airDate = "air_date"
        case episodeNumber = "episode_number"
        case productionCode = "production_code"
        case runtime
        case seasonNumber = "season_number"
        case showID = "show_id"
        case stillPath = "still_path"
    }
}

// MARK: - Network
struct Network: Codable {
    let id: Int
    let logoPath: String?
    let name: String
    let originCountry: OriginCountry

    enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }
}

enum OriginCountry: String, Codable {
    case jp = "JP"
    case us = "US"
}

// MARK: - ProductionCountry
struct ProductionCountry: Codable {
    let iso3166_1: OriginCountry
    let name: String

    enum CodingKeys: String, CodingKey {
        case iso3166_1 = "iso_3166_1"
        case name
    }
}

// MARK: - Recommendations
struct Recommendations: Codable {
    var page: Int?
    var results: [RecommendationsResult] = []
    var totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - RecommendationsResult
struct RecommendationsResult: Codable {
    var adult: Bool?
    var backdropPath: String?
    var id: Int?
    var name: String?
    var title: String?
    //let originalLanguage: OriginalLanguage
    var originalName, overview, posterPath: String?
    var mediaType: String?
    var genreIDS: [Int] = []
    var popularity: Double?
    var firstAirDate: String?
    var releaseDate: String?
    var voteAverage: Double?
    var voteCount: Int?
    var isAds: Bool?
    //let originCountry: [OriginCountry]

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case id, name, title
        //case originalLanguage = "original_language"
        case originalName = "original_name"
        case overview
        case posterPath = "poster_path"
        case mediaType = "media_type"
        case genreIDS = "genre_ids"
        case popularity
        case firstAirDate = "first_air_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case releaseDate = "release_date"
        //case originCountry = "origin_country"
    }
    
    init(){}
    
    init(from decoder: Decoder) throws {
        let container           = try decoder.container(keyedBy: CodingKeys.self)
        adult                   = try? container.decodeIfPresent(Bool.self, forKey: .adult)
        backdropPath            = try? container.decodeIfPresent(String.self, forKey: .backdropPath)
        id                      = try? container.decodeIfPresent(Int.self, forKey: .id)
        name                    = try? container.decodeIfPresent(String.self, forKey: .name)
        title                   = try? container.decodeIfPresent(String.self, forKey: .title)
        originalName            = try? container.decodeIfPresent(String.self, forKey: .originalName)
        overview                = try? container.decodeIfPresent(String.self, forKey: .overview)
        posterPath              = try? container.decodeIfPresent(String.self, forKey: .posterPath)
        mediaType               = try? container.decodeIfPresent(String.self, forKey: .mediaType)
        genreIDS                = try container.decodeIfPresent([Int].self, forKey: .genreIDS) ?? []
        popularity              = try? container.decodeIfPresent(Double.self, forKey: .popularity)
        firstAirDate            = try? container.decodeIfPresent(String.self, forKey: .firstAirDate)
        voteCount               = try? container.decodeIfPresent(Int.self, forKey: .voteCount)
        voteAverage             = try? container.decodeIfPresent(Double.self, forKey: .voteAverage)
        releaseDate             = try? container.decodeIfPresent(String.self, forKey: .releaseDate)
    }
}

// MARK: - Season
struct Season: Codable {
    var airDate: String?
    var episodeCount, id: Int?
    var name, overview, posterPath: String?
    var seasonNumber: Int?
    var episodes: [EpisodeModelData] = []

    enum CodingKeys: String, CodingKey {
        case airDate = "air_date"
        case episodeCount = "episode_count"
        case id, name, overview
        case posterPath = "poster_path"
        case seasonNumber = "season_number"
        case episodes = "episodes"
    }
    
    init(from decoder: Decoder) throws {
        let container           = try decoder.container(keyedBy: CodingKeys.self)
        airDate                 = try? container.decodeIfPresent(String.self, forKey: .airDate)
        episodeCount            = try? container.decodeIfPresent(Int.self, forKey: .episodeCount)
        id                      = try? container.decodeIfPresent(Int.self, forKey: .id)
        name                    = try? container.decodeIfPresent(String.self, forKey: .name)
        overview                = try? container.decodeIfPresent(String.self, forKey: .overview)
        posterPath              = try? container.decodeIfPresent(String.self, forKey: .posterPath)
        seasonNumber            = try? container.decodeIfPresent(Int.self, forKey: .seasonNumber)
        episodes                = try container.decodeIfPresent([EpisodeModelData].self, forKey: .episodes) ?? []
    }
}

// MARK: - SpokenLanguage
struct SpokenLanguage: Codable {
    let englishName: String
    let iso639_1: String
    let name: String

    enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
        case iso639_1 = "iso_639_1"
        case name
    }
}

// MARK: - Videos
struct Videos: Codable {
    var results: [VideosResult] = []
    enum CodingKeys: String, CodingKey {
        case results
    }
    init(from decoder: Decoder) throws {
        let container           = try decoder.container(keyedBy: CodingKeys.self)
        results                 = try container.decodeIfPresent([VideosResult].self, forKey: .results) ?? []
    }
}

// MARK: - VideosResult
struct VideosResult: Codable {
    //var iso639_1: OriginalLanguage?
    //var iso3166_1: OriginCountry?
    var name, key, site: String?
    var size: Int?
    var type: String?
    var official: Bool?
    var publishedAt, id: String?
    var isAds: Bool?

    enum CodingKeys: String, CodingKey {
        //case iso639_1 = "iso_639_1"
        //case iso3166_1 = "iso_3166_1"
        case name, key, site, size, type, official
        case publishedAt = "published_at"
        case id
    }
    
    init(from decoder: Decoder) throws {
        let container       = try decoder.container(keyedBy: CodingKeys.self)
        name                = try? container.decodeIfPresent(String.self, forKey: .name)
        key                 = try? container.decodeIfPresent(String.self, forKey: .key)
        site                = try? container.decodeIfPresent(String.self, forKey: .site)
        size                = try? container.decodeIfPresent(Int.self, forKey: .size)
        type                = try? container.decodeIfPresent(String.self, forKey: .type)
        official            = try? container.decodeIfPresent(Bool.self, forKey: .official)
        publishedAt         = try? container.decodeIfPresent(String.self, forKey: .publishedAt)
        id                  = try? container.decodeIfPresent(String.self, forKey: .id)
    }
    
    init(){}
}
