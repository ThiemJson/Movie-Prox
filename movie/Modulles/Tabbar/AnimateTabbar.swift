//
//  AnimateTabbar.swift
//  movie
//
//  Created by ThiemJason on 05/07/2023.
//

import UIKit
import RxSwift
import RxCocoa

class AnimateTabbar: SHCircleBarController {
    
    let button = UIButton.init(type: .custom)
    let rxDisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setupTabbar()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if HelperUtils.isPad == false {
            let selfieFrame = self.tabBar.subviews[2]
            let wid = selfieFrame.frame.width
            let hei = selfieFrame.frame.height
            self.button.frame = CGRect.init(x: self.tabBar.center.x - (wid / 2), y: self.view.bounds.height - (hei + 30 * 2), width: wid, height: hei) // 30px lấy ở line 82
        }
    }
    
    private func setupView() {
        self.tabBar.isTranslucent   = true
//        self.tabBar.barTintColor    = .rgb(0x557E7E)
//        self.tabBarController?.tabBar.barTintColor  = .rgb(0x557E7E)
        UITabBar.appearance().tintColor = .rgb(0x557E7E)
//
//        if #available(iOS 15.0, *) {
//            //self.tabBar.backgroundColor    = .rgb(0x557E7E)
//        }
    }
    
    private func setupTabbar() {
        /** `Movies` */
        let moviesNav   = MovieTVShowVC(MovieTVShowVMObject()).embedInNavigationController()
        moviesNav.viewControllers.first?.view.backgroundColor = .green
        moviesNav.tabBarItem.image = UIImage(named: "ic_tabbar_moive_untick")
        moviesNav.tabBarItem.selectedImage = UIImage(named: "ic_tabbar_movie_tick")
        moviesNav.tabBarItem.title   = "Movie"
        
        /** `TV Show` */
        let tvShowsNav  = MovieTVShowVC(MovieTVShowVMObject()).embedInNavigationController()
        tvShowsNav.viewControllers.first?.view.backgroundColor = .blue
        tvShowsNav.tabBarItem.image = UIImage(named: "ic_tabbar_tvshow_untick")
        tvShowsNav.tabBarItem.selectedImage = UIImage(named: "ic_tabbar_tvshow_tick")
        tvShowsNav.tabBarItem.title   = "TV Show"
        
        /** `Selfie` */
        let selfieVC = MovieTVShowVC(MovieTVShowVMObject()).embedInNavigationController()
        selfieVC.view.backgroundColor = .systemTeal
        selfieVC.tabBarItem.title   = "Selfie"
        /** `Không thủng` */
        selfieVC.tabBarItem.image = UIImage(named: "ic_tabbar_tvshow_untick")
        selfieVC.tabBarItem.selectedImage = UIImage(named: "ic_tabbar_tvshow_tick")
        
        /** `Setting` */
        let settingVC = MovieTVShowVC(MovieTVShowVMObject()).embedInNavigationController()
        settingVC.view.backgroundColor = .brown
        settingVC.tabBarItem.title = "SettingVC"
        
        /** `Tracking` */
        let trackingVC = MovieTVShowVC(MovieTVShowVMObject()).embedInNavigationController()
        trackingVC.viewControllers.first?.view.backgroundColor = .systemTeal
        trackingVC.tabBarItem.image = UIImage(named: "ic_tabbar_traking_untick")
        trackingVC.tabBarItem.selectedImage = UIImage(named: "ic_tabbar_traking_tick")
        trackingVC.tabBarItem.title = "Tracking"
        
        let favoriteVC = MovieTVShowVC(MovieTVShowVMObject()).embedInNavigationController()
        favoriteVC.viewControllers.first?.view.backgroundColor = .systemYellow
        favoriteVC.tabBarItem.image = UIImage(named: "ic_tabbar_favotite_untick")
        favoriteVC.tabBarItem.selectedImage = UIImage(named: "ic_tabbar_favorite_tick")
        favoriteVC.tabBarItem.title = "Favorite"
        
        //UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.baseOrange], for: .selected)
        //UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: Constant.Color.hex_7A7A7A], for: .normal)
        self.viewControllers  = [moviesNav, tvShowsNav, selfieVC, favoriteVC, trackingVC]
        
        /** `Setup button` */
        self.setupButton()
    }
    
    private func setupButton() {
        self.button.setTitle("", for: .normal)
        self.button.backgroundColor = .clear
        self.view.insertSubview(self.button, aboveSubview: self.tabBar)
        
        self.button.rx.tap.asDriver()
            .drive(onNext: { [weak self] _ in
                guard let `self` = self else { return }
                if self.tabBar.isHidden { return }
                self.selectedIndex = 2
            })
            .disposed(by: self.rxDisposeBag)
    }
}
