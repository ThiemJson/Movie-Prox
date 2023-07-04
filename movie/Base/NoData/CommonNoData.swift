//
//  CommonNoData.swift
//  movie-buff
//
//  Created by Prox on 03/05/2023.
//  Copyright © 2023 Prox. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

enum NoDataType {
    case Favorite
    case SearchNoData
    case Tracking
    case Search
}

class CommonNoData: UIView {
    static let nibName = "CommonNoData"
    @IBOutlet var mainView          : UIView!
    @IBOutlet weak var vContentView : UIView!
    @IBOutlet weak var imgNodata    : UIImageView!
    @IBOutlet weak var lblTitle1    : UILabel!
    @IBOutlet weak var lblTitle2    : UILabel!
    @IBOutlet weak var vBtn         : UIView!
    @IBOutlet weak var lblBtn       : UILabel!
    let rxDisposeBag                = DisposeBag()
    let rxType                      = BehaviorRelay<NoDataType>.init(value: .SearchNoData)
    
    @IBOutlet weak var constImgPaddignToFirstTitle  : NSLayoutConstraint!
    @IBOutlet weak var constContentVert             : NSLayoutConstraint!
    @IBOutlet weak var cotnrstIcon                  : NSLayoutConstraint!
    
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
        self.rxType.accept(self.rxType.value)
    }
    
    /** Init view */
    private func initializedView() {
        Bundle.main.loadNibNamed(CommonNoData.nibName, owner: self, options: nil)
        self.addSubview(self.mainView)
        self.mainView.frame = self.bounds
        self.mainView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.backgroundColor                = .clear
        self.vContentView.backgroundColor   = .clear
        
        self.rxType.asDriver().drive(onNext: { [weak self] (type) in
            guard let `self` = self else { return}
            
            switch type {
            case .Favorite:
                self.constContentVert.constant  = -(self.imgNodata.frame.height * 0.5)
                self.cotnrstIcon = self.cotnrstIcon.setMultiplier(multiplier: (108 / 375))
                self.vBtn.isHidden      = true
                self.lblTitle2.isHidden = false
                self.imgNodata.image    = UIImage.init(named: BaseIcon.Empty.favorite)
                self.lblTitle1.font     = BaseFont.Libre.Cell.title
                self.lblTitle2.font     = BaseFont.Libre.Cell.caption
                self.lblTitle2.textColor = .white
                self.lblTitle1.textColor = UIColor.baseOrange
            case .Search:
                self.cotnrstIcon = self.cotnrstIcon.setMultiplier(multiplier: (170 / 375))
                self.constImgPaddignToFirstTitle.constant   = -8
                self.vBtn.isHidden      = true
                self.lblTitle2.isHidden = true
                self.lblTitle1.font     = BaseFont.Libre.Cell.title
                self.lblTitle1.textColor = Constant.Color.hex_7A7A7A
                self.imgNodata.image    = UIImage.init(named: BaseIcon.Empty.search)
            case .SearchNoData:
                self.cotnrstIcon = self.cotnrstIcon.setMultiplier(multiplier: (92 / 375))
                self.constImgPaddignToFirstTitle.constant   = 8
                self.vBtn.isHidden      = true
                self.lblTitle2.isHidden = true
                self.lblTitle1.text     = "Oh sorry\nNo search results"
                self.lblTitle1.font     = BaseFont.Libre.Cell.title
                self.lblTitle1.textColor = Constant.Color.hex_7A7A7A
                self.imgNodata.image    = UIImage.init(named: BaseIcon.Empty.searchNoData)
            case .Tracking:
                self.constContentVert.constant  = -(self.imgNodata.frame.height / 3)
                self.cotnrstIcon = self.cotnrstIcon.setMultiplier(multiplier: (185/375))
                self.lblTitle2.isHidden = true
                self.vBtn.isHidden = false
                self.imgNodata.image    = UIImage.init(named: BaseIcon.Empty.tracking)
                self.lblTitle1.text     = "You don’t have any watchlist yet"
                self.lblTitle1.font     = UIFont.font(size: HelperUtils.isPad ? 16 : 14, weight: .medium)
                self.lblTitle1.textColor = .white
                self.setupBtn()
            }
            
        }).disposed(by: self.rxDisposeBag)
    }
    
    private func setupBtn() {
        self.lblBtn.text    = "Add to watchlist"
        self.lblBtn.font    = BaseFont.Libre.Cell.title
        self.lblBtn.textColor       = UIColor.baseOrange
        self.vBtn.backgroundColor   = .clear
        self.vBtn.layer.borderColor    = UIColor.baseOrange.cgColor
        self.vBtn.layer.borderWidth    = 1.5
        self.vBtn.layer.cornerRadius   = 9.0
        self.vBtn.layer.masksToBounds  = true
    }
}
