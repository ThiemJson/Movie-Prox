//
//  BaseIcon.swift
//  movie-buff
//
//  Created by Prox on 27/04/2023.
//  Copyright © 2023 Prox. All rights reserved.
//

import Foundation
struct BaseIcon {
    struct Common {
        static var backward     : String { "ic_back_white" }
        static var backward_orange  : String { "ic_back_orange" }
        static var forward      : String { "ic_forward" }
        static var down         : String { "ic_down_white" }
        static var down_gray    : String { "ic_down_gray" }
        static var up           : String { "ic_up_white" }
        static var star         : String { "ic_star" }
        static var un_star      : String { "ic_un_star" }
        static var un_star_gray : String { "ic_star_gray" }
    }
    
    struct Empty {
        static var favorite     : String { "ic_empty_favorite" }
        static var searchNoData : String { "ic_face_sad" }
        static var search       : String { "ic_search" }
        static var tracking     : String { "ic_empty_statistical" }
    }
    
    struct Search {
        static var cancel       : String { "ic_close_gray" }
        static var faceSad      : String { "ic_face_sad" }
        static var search       : String { "ic_search_normal" }
    }
    
    struct Setting {
        static var privacy      : String { "ic_setting_privacy" }
        static var rating       : String { "ic_setting_rating" }
        static var share        : String { "ic_setting_share" }
        static var feedback     : String { "ic_setting_feedback" }
        static var setting      : String { "ic_setting" }
    }
    
    struct Favorite {
        static var heart        : String { "ic_favorite" }
        static var un_heart     : String { "ic_un_favorite_orange" }
        static var un_heart_orange : String { "ic_un_favorite_orange" }
        static var sun          : String { "sun" }
    }
    
    struct Selfie {
        static var flash        : String { "ic_selfie_flash" }
        static var flashing     : String { "ic_selfie_flashing" }
    }
    
    struct Button {
        static var dpDown       : String { "ic_dp_down" }
        static var dpUp         : String { "ic_dp_up" }
        static var play         : String { "ic_play" }
        static var play_circle  : String { "ic_play_circle" }
        static var plus         : String { "ic_plus" }
    }
}
