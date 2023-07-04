//
//  WatchingSessionModel.swift
//  movie-buff
//
//  Created by Prox on 26/05/2023.
//  Copyright © 2023 Prox. All rights reserved.
//

import Foundation
struct WatchingSessionModel: Codable {
    var endTime         : Int?
    var mediaId         : Int?
    var startTime       : Int?
    var totalDuration   : Int?
    var watchDuration   : Int?
    var uuid            : String?
    var backdropPath    : String?
    var id              : Int?
    var subtitle        : String?
    var overview        : String?
    var voteAvarage     : Double?
    var name            : String?
    var mediaType       : String?
    
    static func create(data: MovieModelData) -> WatchingSessionModel {
        var watchingSession             = WatchingSessionModel()
        watchingSession.backdropPath    = data.backdropPath
        watchingSession.id              = data.id
        watchingSession.name            = data.title ?? data.originalTitle
        watchingSession.voteAvarage     = data.voteAverage
        watchingSession.overview        = data.overview
        
        let date = (data.releaseDate ?? "").prefix(4)
        let sub     = ""//HelperUtils.getSubFromDateAndGenres(date: date.description, genres: Array(data.genresID.prefix(2)))
        watchingSession.subtitle        = sub
        watchingSession.uuid            = UUID().uuidString
        watchingSession.mediaId         = data.id
        watchingSession.mediaType       = "movie"
        return watchingSession
    }
    
    static func create(data: TVShowModelData) -> WatchingSessionModel {
        var watchingSession             = WatchingSessionModel()
        watchingSession.backdropPath    = data.backdropPath
        watchingSession.id              = data.id
        watchingSession.name            = data.name ?? data.originalName
        watchingSession.voteAvarage     = data.voteAverage
        watchingSession.overview        = data.overview
        
        let date = (data.firstAirDate ?? "").prefix(4)
        let sub     = ""//HelperUtils.getSubFromDateAndGenres(date: date.description, genres: Array(data.genresID.prefix(2)))
        watchingSession.subtitle        = sub
        watchingSession.uuid            = UUID().uuidString
        watchingSession.mediaId         = data.id
        watchingSession.mediaType       = "tv"
        return watchingSession
    }
    
    static func createTempWatchSession(data: Any?, time: Date) -> WatchingSessionModel? {
        let startTime               = Int(time.timeIntervalSince1970 + 60) // Để nó chắc chắn trong ngày đó
        let endTime                 = startTime
        let watchDuration           = 0
        
        if let data = data as? MovieModelData {
            var watchingSession             = WatchingSessionModel()
            watchingSession.backdropPath    = data.backdropPath
            watchingSession.id              = data.id
            watchingSession.name            = data.title ?? data.originalTitle
            watchingSession.voteAvarage     = data.voteAverage
            watchingSession.overview        = data.overview
            
            let date = (data.releaseDate ?? "").prefix(4)
            let sub     = ""//HelperUtils.getSubFromDateAndGenres(date: date.description, genres: Array(data.genresID.prefix(2)))
            watchingSession.subtitle        = sub
            watchingSession.uuid            = UUID().uuidString
            watchingSession.mediaId         = data.id
            watchingSession.mediaType       = "movie"
            
            /** `Fake thời gian xem` */
            watchingSession.startTime       = startTime
            watchingSession.endTime         = endTime
            watchingSession.watchDuration   = watchDuration
            watchingSession.totalDuration   = 0
            
            return watchingSession
        }
        
        if let data = data as? TVShowModelData {
            var watchingSession             = WatchingSessionModel()
            watchingSession.backdropPath    = data.backdropPath
            watchingSession.id              = data.id
            watchingSession.name            = data.name ?? data.originalName
            watchingSession.voteAvarage     = data.voteAverage
            watchingSession.overview        = data.overview
            
            let date = (data.firstAirDate ?? "").prefix(4)
            let sub     = ""//HelperUtils.getSubFromDateAndGenres(date: date.description, genres: Array(data.genresID.prefix(2)))
            watchingSession.subtitle        = sub
            watchingSession.uuid            = UUID().uuidString
            watchingSession.mediaId         = data.id
            watchingSession.mediaType       = "tv"
            
            /** `Fake thời gian xem` */
            watchingSession.startTime       = startTime
            watchingSession.endTime         = endTime
            watchingSession.watchDuration   = watchDuration
            watchingSession.totalDuration   = 0
            
            return watchingSession
        }
        
        return nil
    }
}
