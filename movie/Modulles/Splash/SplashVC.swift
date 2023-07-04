//
//  SplashVC.swift
//  movie
//
//  Created by Prox on 03/05/2023.
//  Copyright © 2023 Prox. All rights reserved.
//

import UIKit
import GoogleMobileAds

class SplashVC: BaseViewModelController<SplashVM> {
    @IBOutlet weak var constAppIcon: NSLayoutConstraint!
    @IBOutlet weak var constAppName: NSLayoutConstraint!
    var timer : Timer?
    
    deinit {
        self.timer?.invalidate()
        self.timer = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled   = false
        self.pushToDashboard()
        return;
        PingManager.shared.checkInternetConnection { [weak self] isReachable in
            guard let `self` = self else { return }
            if isReachable {
                self.setupInterstitialAds { [weak self] (isSuccess) in
                    guard let `self` = self else { return }
                    if isSuccess {
                        print("interstitialAd ==> present")
                        self.interstitialAd?.present(fromRootViewController: self)
                    } else {
                        self.pushToDashboard()
                    }
                }
            } else {
                AppMessagesManager.shared.showMessage(messageType: .error, message: "Internet error")
                //                /** `Show InternerError screen` */
                //                let internetErorVC  = InternetErrorVC(InternetErrorVMObject())
                //                internetErorVC.isReplaceRoot = true
                //                let window          = UIApplication.shared.windows.first(where: { $0.isKeyWindow })
                //                let transition      = CATransition()
                //                transition.duration         = 0.3
                //                transition.timingFunction   = CAMediaTimingFunction(
                //                    name: CAMediaTimingFunctionName.easeOut
                //                )
                //                transition.type     = .push
                //                transition.subtype  = .fromBottom
                //                window?.layer.add(transition, forKey: kCATransition)
                //                window?.rootViewController = internetErorVC
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        return;
        self.constAppIcon.constant = 0
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: {_ in
            self.constAppName.constant = 0
            UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseInOut, animations: {
                self.view.layoutIfNeeded()
            }, completion: { [weak self] _ in
                guard let `self` = self else { return }
                self.timer  = Timer.scheduledTimer(withTimeInterval: 30, repeats: false, block: { [weak self] _ in
                    guard let `self` = self else { return }
                    self.pushToDashboard()
                })
            })
        })
    }
    
    private func pushToDashboard() {
        self.timer?.invalidate()
        self.timer  = nil
        let tabbar = AnimateTabbar()
        self.replaceRoot(to: tabbar,
                         withTransitionType: .push,
                         andTransitionSubtype: .fromRight,
                         isWitNavbar: false)
    }
    
    override func adWillDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        
    }
}
