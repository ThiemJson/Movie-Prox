//
//  ListMovieContentCell.swift
//  movie-buff
//
//  Created by Prox on 07/05/2023.
//  Copyright © 2023 Prox. All rights reserved.
//

import UIKit
import FSPagerView
import RxSwift
import RxCocoa

protocol ListMovieContentCellDelegate : NSObjectProtocol {
    func didSelectShowDetail(data: Any?)
    func didSelectPlay(data: Any?)
}

class ListMovieContentCell: FSPagerViewCell {
    static let nibName  = "ListMovieContentCell"
    @IBOutlet weak var imgContent   : UIImageView!
    @IBOutlet weak var vContentView : UIView!
    @IBOutlet weak var imgAvt       : UIImageView!
    @IBOutlet weak var lblName      : UILabel!
    @IBOutlet weak var lblSub       : UILabel!
    @IBOutlet weak var lblRating    : UILabel!
    weak var delegate               : ListMovieContentCellDelegate?
    var data                        : Any?
    let rxDisposeBag                = DisposeBag()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.imgContent.layer.cornerRadius = 10
        self.imgContent.clipsToBounds = true
        self.imgAvt.layer.cornerRadius = self.imgAvt.frame.height / 2
        self.imgAvt.clipsToBounds = true
        self.layoutIfNeeded()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor        = .clear
        self.vContentView.backgroundColor   = .clear
        self.backgroundColor = .clear
        
        self.imgAvt.layer.cornerRadius = self.imgAvt.frame.height / 2
        self.imgAvt.clipsToBounds = true
        
        self.contentView.layer.shadowColor = UIColor.clear.cgColor
        self.contentView.layer.shadowRadius = 0
        self.contentView.layer.shadowOpacity = 0
        self.contentView.layer.shadowOffset = .zero
        
        self.lblName.font = UIFont.font(size: 18, weight: .semibold)
        self.lblName.textColor = .rgb(0x090909)
        
        self.lblSub.font = UIFont.font(size: 12, weight: .regular)
        self.lblSub.textColor = .rgb(0x555555)
        
        self.lblRating.font = UIFont.font(size: 12, weight: .regular)
        self.lblRating.textColor = .rgb(0x555555)
        
        self.imgContent.rx.tap().asObservable().onMain()
            .subscribe(onNext: { [weak self] _ in
                guard let `self` = self else { return }
                self.delegate?.didSelectShowDetail(data: self.data)
            })
            .disposed(by: self.rxDisposeBag)
    }
}
