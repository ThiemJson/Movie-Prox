//
//  FVPageActorCell.swift
//  movie-buff
//
//  Created by Prox on 30/04/2023.
//  Copyright © 2023 Prox. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class FVPageActorCell: UICollectionViewCell {
    static let nibName = "FVPageActorCell"
    @IBOutlet weak var vContentView : UIView!
    @IBOutlet weak var imgActor     : UIImageView!
    @IBOutlet weak var lblActor     : UILabel!
    @IBOutlet weak var constActorNameWid: NSLayoutConstraint!
    @IBOutlet weak var vImage       : UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupUI()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.vContentView.frame.size        = self.bounds.size
        self.vImage.clipsToBounds           = true
        self.vImage.layer.cornerRadius      = 8
        self.layoutIfNeeded()
    }
    
    private func setupUI() {
        self.vContentView.backgroundColor   = .clear
        self.backgroundColor                = .clear
        self.imgActor.contentMode           = .scaleAspectFill
        self.vImage.clipsToBounds           = true
        self.vImage.layer.cornerRadius      = 8
        self.lblActor.textColor             = .textPrimary
        let font                            = UIFont.font(size: 12, weight: .medium)
        self.lblActor.font                  = font
        self.lblActor.numberOfLines         = 2
    }
}
