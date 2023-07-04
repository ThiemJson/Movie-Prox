//
//  EpisodeModelData.swift
//  movie-buff
//
//  Created by Prox on 5/11/23.
//  Copyright © 2023 Prox. All rights reserved.
//

// MARK: - EpisodeModelData
struct EpisodeModelData: Codable {
    var airDate: String?
    var crew: [CrewElement]?
    var episodeNumber: Int?
    //var guestStars: [JSONAny]?
    var name, overview: String?
    var id: Int?
    var productionCode: String?
    var runtime, seasonNumber: Int?
    var stillPath: String?
    var voteAverage: Double?
    var voteCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case airDate = "air_date"
        case crew
        case episodeNumber = "episode_number"
        //case guestStars = "guest_stars"
        case name, overview, id
        case productionCode = "production_code"
        case runtime
        case seasonNumber = "season_number"
        case stillPath = "still_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
    init(from decoder: Decoder) throws {
        let container   = try decoder.container(keyedBy: CodingKeys.self)
        airDate         = try? container.decodeIfPresent(String.self, forKey: .airDate)
        crew            = try? container.decodeIfPresent([CrewElement].self, forKey: .crew) ?? []
        episodeNumber   = try? container.decodeIfPresent(Int.self, forKey: .episodeNumber)
        name            = try? container.decodeIfPresent(String.self, forKey: .name)
        overview        = try? container.decodeIfPresent(String.self, forKey: .overview)
        id              = try? container.decodeIfPresent(Int.self, forKey: .id)
        productionCode  = try? container.decodeIfPresent(String.self, forKey: .productionCode)
        runtime         = try? container.decodeIfPresent(Int.self, forKey: .runtime)
        seasonNumber    = try? container.decodeIfPresent(Int.self, forKey: .seasonNumber)
        voteAverage     = try? container.decodeIfPresent(Double.self, forKey: .voteAverage)
        voteCount       = try? container.decodeIfPresent(Int.self, forKey: .voteCount)
        stillPath       = try? container.decodeIfPresent(String.self, forKey: .stillPath)
    }
}

//// MARK: - Crew
//struct Crew: Codable {
//    var department, job, creditID: String?
//    var adult: Bool?
//    var gender, id: Int?
//    var knownForDepartment, name, originalName: String?
//    var popularity: Double?
//    var profilePath: String?
//
//    enum CodingKeys: String, CodingKey {
//        case department, job
//        case creditID = "credit_id"
//        case adult, gender, id
//        case knownForDepartment = "known_for_department"
//        case name
//        case originalName = "original_name"
//        case popularity
//        case profilePath = "profile_path"
//    }
//}
