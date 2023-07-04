//
//  BaseImage.swift
//  movie-buff
//
//  Created by Prox on 27/04/2023.
//  Copyright © 2023 Prox. All rights reserved.
//

import Foundation
struct BaseImage {
    struct Search {
        static var movie: String { "img_movie" }
        static var movieHori: String { "img_movie_horizontal" }
        static var person: String { "img_human" }
    }
    
    struct Movie {
        static var background: String { "movie_background" }
    }
    
    struct Setting {
        static var background: String { "setting_background" }
    }
    
    struct Favorite {
        static var background: String { "favorite_background" }
    }
    
    struct Selfie {
        static var ic_frame_01: String { "ic_frame_01" }
        static var ic_frame_02: String { "ic_frame_02" }
        static var ic_frame_03: String { "ic_frame_03" }
        static var ic_frame_04: String { "ic_frame_04" }
        static var ic_frame_05: String { "ic_frame_05" }
        
        static var ic_frame_poster_01: String { "ic_frame_poster_01" }
        static var ic_frame_poster_02: String { "ic_frame_poster_02" }
        static var ic_frame_poster_03: String { "ic_frame_poster_03" }
        static var ic_frame_poster_04: String { "ic_frame_poster_04" }
        static var ic_frame_poster_05: String { "ic_frame_poster_05" }
    }
}
