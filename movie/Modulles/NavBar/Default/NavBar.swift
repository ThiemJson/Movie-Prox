//
//  NavBar.swift
//  movie-buff
//
//  Created by Prox on 27/04/2023.
//  Copyright © 2023 Prox. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

enum NavBarType {
    case Default
    case Search
    case MoviesTVShow
    case Detail
}

class NavBar: UIView {
    static let nibName              = "NavBar"
    static let commonRatio          = CGFloat(50/673)
    
    @IBOutlet var mainView          : UIView!
    @IBOutlet weak var imgLeftIcon  : UIImageView!
    @IBOutlet weak var imgRight     : UIImageView!
    @IBOutlet weak var imgRight2    : UIImageView!
    @IBOutlet weak var lblTItle     : UILabel!
    @IBOutlet weak var vSearchBar   : SearchBar!
    @IBOutlet weak var vButton      : BaseButton!
    @IBOutlet weak var cosntImgBack: NSLayoutConstraint!
    @IBOutlet weak var constImgRight: NSLayoutConstraint!
    
    let rxDisposeBag                = DisposeBag()
    let rxType                      = BehaviorRelay<NavBarType>.init(value: .Default)
    
    // MARK: Setting UI View
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initializedView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initializedView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if self.rxType.value == .MoviesTVShow {
            self.vButton.cornerRadius                       = Int(self.vButton.vContentView.frame.height / 2)
            self.vButton.vContentView.layer.cornerRadius    = self.vButton.vContentView.frame.height / 2
            self.vButton.vContentView.clipsToBounds         = true
        }
        self.layoutIfNeeded()
    }
    
    /** Init view */
    private func initializedView() {
        Bundle.main.loadNibNamed(NavBar.nibName, owner: self, options: nil)
        self.addSubview(self.mainView)
        self.mainView.frame = self.bounds
        self.mainView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        self.imgLeftIcon.tintColor  = .white
        self.lblTItle.textColor     = .white
        self.lblTItle.font          = UIFont.font(size: HelperUtils.isPad ? 26 : 20, weight: .semibold)
        self.imgLeftIcon.image      = UIImage(named: BaseIcon.Common.backward_orange)
        
        self.rxType.asDriver()
            .drive(onNext: { [weak self] (type) in
                guard let `self` = self else { return }
                switch type {
                case .Default:
                    self.vSearchBar.isHidden    = true
                    self.imgRight2.isHidden     = true
                    self.imgRight.isHidden      = true
                case .Search:
                    self.vSearchBar.isHidden    = false
                    self.lblTItle.isHidden      = true
                    self.imgRight2.isHidden     = true
                case .MoviesTVShow:
                    self.vButton.isHidden           = true
                    //                    self.vButton.cornerRadius       = Int(self.vButton.vContentView.frame.height / 2)
                    //                    self.vButton.vContentView.backgroundColor = UIColor.tabbarBackground.withAlphaComponent(0.65)
                    //                    self.vButton.imgLeft.isHidden   = true
                    //                    self.vButton.imgRight.isHidden  = false
                    //                    self.vButton.lblTitle.text      = "Genres"
                    //                    self.vButton.lblTitle.font      = UIFont.font(size: HelperUtils.isPad ? 26 : 18, weight: .semibold)
                    //                    self.vButton.lblTitle.textColor = .white.withAlphaComponent(0.9)
                    //                    self.vButton.imgRight.tintColor = .white
                    //                    self.vButton.imgRight.image     = UIImage.init(named: BaseIcon.Common.down)
                    //                    self.vButton.constrWidthIcon.constant = HelperUtils.isPad ? 24 : 22
                    //                    self.vButton.clipsToBounds      = true
                    
                    self.lblTItle.isHidden      = true
                    self.imgLeftIcon.isHidden   = true
                    self.imgRight2.isHidden     = false
                    self.imgRight.isHidden      = false
                    self.imgRight.contentMode   = .scaleToFill
                    self.imgRight2.contentMode  = .scaleToFill
                    self.imgRight.image         = UIImage(named: BaseIcon.Setting.setting)
                    self.constImgRight          = self.constImgRight.setMultiplier(multiplier: 1.2)
                    self.imgRight2.image        = UIImage(named: BaseIcon.Search.search)
                    self.imgRight.tintColor     = .white
                    self.imgRight2.tintColor    = .white
                case .Detail:
                    self.lblTItle.isHidden      = true
                    self.imgRight2.isHidden     = true
                    self.imgRight.image         = UIImage.init(named: BaseIcon.Favorite.un_heart)
                    self.imgRight.tintColor     = .white
                    self.imgRight.isHidden      = false
                    self.imgLeftIcon.tintColor  = .white
                }
                self.layoutSubviews()
            })
            .disposed(by: self.rxDisposeBag)
    }
}
