//
//  BaseButton.swift
//  movie-buff
//
//  Created by Prox on 5/5/23.
//  Copyright © 2023 Prox. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class BaseButton: UIView {
    static let nibName = "BaseButton"
    @IBOutlet var mainView              : UIView!
    @IBOutlet weak var stvMain          : UIStackView!
    
    @IBOutlet weak var stv2             : UIStackView!
    @IBOutlet weak var lblTitl2         : UILabel!
    @IBOutlet weak var imgLeftStv2      : UIImageView!
    
    @IBOutlet weak var vContentView     : UIView!
    @IBOutlet weak var imgLeft          : UIImageView!
    @IBOutlet weak var lblTitle         : UILabel!
    @IBOutlet weak var imgRight         : UIImageView!
    @IBOutlet weak var constrWidthIcon  : NSLayoutConstraint!
    @IBOutlet weak var leftPadding      : NSLayoutConstraint!
    @IBOutlet weak var rightPadding     : NSLayoutConstraint!
    @IBOutlet weak var topPadding       : NSLayoutConstraint!
    @IBOutlet weak var bottomPadding    : NSLayoutConstraint!
    
    let rxDisposeBag                    = DisposeBag()
    var cornerRadius                    = Constant.Values.commonRadius
    
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
        self.vContentView.frame.size            = self.mainView.bounds.size
        self.vContentView.layer.cornerRadius    = CGFloat(self.cornerRadius)
        self.vContentView.clipsToBounds         = true
    }
    
    private func initializedView() {
        Bundle.main.loadNibNamed(BaseButton.nibName, owner: self, options: nil)
        self.addSubview(self.mainView)
        self.mainView.frame = self.bounds
        self.mainView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        /** `Default hidden` */
        self.imgLeft.isHidden   = true
        self.imgRight.isHidden  = true
        
        self.vContentView.backgroundColor       = .clear
        self.lblTitle.textColor                 = .white
        self.lblTitle.font                      = BaseFont.Libre.Button.title
    }
    
    func setBorder(color: CGColor? = UIColor.baseOrange.cgColor) {
        self.vContentView.layer.borderColor     = color
        self.vContentView.layer.borderWidth     = 1.5
    }
    
    func setButtonStyleTracking() {
        self.setBorder()
        self.imgRight.isHidden          = false
        self.stvMain.spacing            = 0
        self.imgRight.image             = UIImage.init(named: BaseIcon.Common.up)
        self.imgRight.transform         = CGAffineTransform(scaleX: 1.5, y: 1.5)
        self.imgRight.tintColor         = .white
    }
    
    func setButtonStylePlay() {
        self.constrWidthIcon.constant  = 19
        self.leftPadding.constant      = 18
        self.rightPadding.constant     = 18
        self.topPadding.constant       = 10
        self.bottomPadding.constant    = 10
        self.lblTitle.textColor        = .baseOrange
    }
    
    func setButtonStyleMore() {
        self.lblTitle.text              = "More"
        self.lblTitle.textColor         = .white
        self.lblTitle.font              = UIFont.font(size: HelperUtils.isPad ? 24 : 17, weight: .regular)
        self.imgLeft.isHidden           = true
        self.imgRight.isHidden          = false
        self.lblTitle.textAlignment     = .right
        self.imgRight.image             = UIImage.init(named: BaseIcon.Common.forward)
        self.constrWidthIcon.constant   = HelperUtils.isPad ? 15 : 13
        self.imgRight.tintColor         = .white
        self.stvMain.spacing            = HelperUtils.isPad ? 10 : 6
    }
    
    func setBtnStyleAddWatchlist_un_Checked() {
        self.stv2.isHidden                  = true
        self.stvMain.isHidden               = false
        self.vContentView.backgroundColor   = .baseOrange
        self.setButtonStylePlay()
        self.lblTitle.text                  = "Add to watchlist"
        self.lblTitle.textColor             = .baseOrange
        self.imgRight.isHidden              = true
        self.imgLeft.isHidden               = false
        self.imgLeft.image                  = UIImage.init(named: BaseIcon.Button.plus)
        self.constrWidthIcon.constant       = 26
        self.stvMain.spacing                = 4
        self.stv2.spacing                   = 4
        self.leftPadding.constant           = 8
        self.vContentView.backgroundColor   = .clear
    }
    
    func setBtnStyleAddWatchlist_Checked() {
        self.stvMain.isHidden               = true
        self.stv2.isHidden                  = false
        self.lblTitl2.text                  = "Added"
        self.lblTitl2.textColor             = .white
        self.lblTitl2.font                  = BaseFont.Libre.Button.title
        self.lblTitl2.textAlignment         = .center
        self.imgLeftStv2.isHidden           = false
        self.imgLeftStv2.image              = UIImage.init(named: "ic_check")
        self.imgLeftStv2.tintColor          = .white
        self.stv2.spacing                   = HelperUtils.isPad ? 10 : 6
        self.constrWidthIcon.constant       = 26
        self.stvMain.spacing                = 4
        self.stv2.spacing                   = 4
        self.leftPadding.constant           = 8
        self.vContentView.backgroundColor   = .baseOrange
    }
    
    func setBtnTrackingActive() {
        self.vContentView.layer.borderColor     = UIColor.baseOrange.cgColor
        self.vContentView.layer.borderWidth     = 1.5
        self.imgRight.tintColor                 = .white
        self.lblTitle.textColor                 = .white
        self.imgRight.image                     = UIImage.init(named: BaseIcon.Common.down)
    }
    
    func setBtnTrackingUnActive() {
        self.vContentView.layer.borderColor     = Constant.Color.hex_7A7A7A.cgColor
        self.vContentView.layer.borderWidth     = 1.5
        self.imgRight.tintColor                 = Constant.Color.hex_7A7A7A
        self.lblTitle.textColor                 = Constant.Color.hex_7A7A7A
        self.imgRight.image                     = UIImage.init(named: BaseIcon.Common.down_gray)
    }
}
