//
//  HelperUtils.swift
//  movie
//
//  Created by Prox on 05/07/2023.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

struct HelperUtils {
    /** `Khởi động ở giá trị 2 để lần đầu tiên luôn hiển thị` */
    public static var interstitial_ads_movie = 2
    public static var rewarded_ads_movie = 2
    public static var recentlyUsedFrame = [String]()
    public static var isCommentCodeForBuild = false
    public static var isPad = Bool()
    public static var rxIsHiddenAdsInFavorite = BehaviorRelay<Bool>.init(value: true)
    public static let text4Line = "The powerful and influential Fiero clan celebrates the 15th anniversary of their cockpit arena built on the remains of a tragic and bloody past. A girl stops at nothing until she unravels the mystery behind her mother's disappearance."
    
    public static let text4Lineipad = "2003. As a parasitic fungal outbreak begins to ravage the country and the world, Joel Miller attempts to escape the escalating chaos with his daughter and brother. Twenty years later, a now hardened Joel and his partner Tess fight to survive under a totalitarian regime, while the insurgent Fireflies"
    
    public static let heiOfText4Line = HelperUtils.text4Line.height(withConstrainedWidth: UIScreen.main.bounds.width, font: UIFont.font(size: HelperUtils.isPad ? 18 : 13, weight: .regular))
    
    public static let heiOfText4Lineipad = HelperUtils.text4Lineipad.height(withConstrainedWidth: UIScreen.main.bounds.width - 48, font: UIFont.font(size: HelperUtils.isPad ? 19 : 13, weight: .regular))
    
    public static var badgeCount = 0 {
        didSet {
            // Cập nhật lại số thông báo ở icon app ngoài màn hình ứng dụng
            UNUserNotificationCenter.current().requestAuthorization(options: .badge) { (granted, error) in
                if error != nil { return }
                DispatchQueue.main.async {
                    UIApplication.shared.applicationIconBadgeNumber =  HelperUtils.badgeCount
                }
            }
        }
    }
    
    /** `Image patch` */
    enum ImageSize : String {
        case original   = "original"
        case w500       = "w500"
        case w300       = "w300"
        case w200       = "w200"
    }
    
    static func getImageLink(url: String, size: HelperUtils.ImageSize = .w500 ) -> String {
        return "\(BaseRouter.baseImgURL)/\(size.rawValue)\(url)"
    }
    
    //    static func getSubFromDateAndGenres(date: String, genres: [Int], prefix: Int = 3) -> String {
    //        var sub     = ""
    //        let genres  = genres.prefix(prefix).map { HomeDashboardVC.GENRES[$0]?.name ?? "" }
    //        genres.forEach { item in
    //            if item.isEmpty == false {
    //                sub += "\(item) | "
    //            }
    //        }
    //        if date.isEmpty {
    //            return sub.trimmingCharacters(in: .whitespaces).prefix( max(sub.count - 2, 0)).description
    //        }
    //        return "\(sub) \(date)".trimmingCharacters(in: .whitespaces)
    //    }
}

