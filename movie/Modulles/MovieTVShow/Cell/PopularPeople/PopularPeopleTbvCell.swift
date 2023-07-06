//
//  HDPopularPeopleCell.swift
//  movie-buff
//
//  Created by Prox on 07/05/2023.
//  Copyright © 2023 Prox. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class PopularPeopleTbvCell: UITableViewCell {
    @IBOutlet weak var vContentView     : UIView!
    @IBOutlet weak var vHeader          : UIView!
    @IBOutlet weak var lblTitle         : UILabel!
    @IBOutlet weak var lblSeeAll        : UILabel!
    @IBOutlet weak var clvContent       : UICollectionView!
    @IBOutlet weak var constClvHeight   : NSLayoutConstraint!
    @IBOutlet weak var constHeaderHei   : NSLayoutConstraint!
    
    static let nibName                  = "PopularPeopleTbvCell"
    var type                            = MovieTVShowType.Movie
    var isFromDetailMovie               = false
    let rxDisposeBag                    = DisposeBag()
    var isOnelineActorName              = false
    var contentData                     = [PersonModelData]() {
        didSet {
            self.clvContent.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.setupUI()
        self.setupClv()
        self.setupBinding()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if self.contentData.isEmpty {
            self.constClvHeight.constant    = 0
        } else {
            let size    = self.frame.size
            let width   = (HelperUtils.isPad == false) ? size.width * (220 / 1191) : ((size.width - (50 * 3)) / 5)
            self.constClvHeight.constant    = width + self.getHeiOfCell(wid: width)
        }
        self.layoutIfNeeded()
    }
    
    func updateUI() {
        if self.contentData.isEmpty {
            self.constClvHeight.constant    = 0
        } else {
            let size    = self.frame.size
            let width   = (HelperUtils.isPad == false) ? size.width * (220 / 1191) : ((size.width - (50 * 3)) / 5)
            self.constClvHeight.constant    = width + self.getHeiOfCell(wid: width)
        }
        self.layoutIfNeeded()
    }
    
    private func setupUI() {
        self.vContentView.backgroundColor   = UIColor.baseBackground
        self.lblSeeAll.font = UIFont.font(size: 12, weight: .regular)
        self.lblSeeAll.text = "See all"
        self.lblSeeAll.makeUnderline()
        self.lblSeeAll.textColor = .rgb(0x1E2C2C)
        
        self.lblTitle.font = UIFont.font(size: 16, weight: .semibold)
        self.lblTitle.textColor = .textPrimary
        
        if self.contentData.isEmpty {
            self.constClvHeight.constant    = 0
        } else {
            let size    = self.frame.size
            let width   = (HelperUtils.isPad == false) ? size.width * (220 / 1191) : ((size.width - (50 * 3)) / 5)
            self.constClvHeight.constant    = width + self.getHeiOfCell(wid: width)
        }
    }
    
    private func setupBinding() {
        
    }
    
    private func setupClv() {
        self.clvContent.showsVerticalScrollIndicator    = false
        self.clvContent.showsHorizontalScrollIndicator  = false
        self.clvContent.dataSource      = self
        self.clvContent.delegate        = self
        
        let cell = UINib(nibName: FVPageActorCell.nibName, bundle: nil)
        self.clvContent.register(cell, forCellWithReuseIdentifier: FVPageActorCell.nibName)
    }
    
    private func getHeiOfCell(wid: CGFloat) -> CGFloat {
        let heiText = "Gary oldman".height(withConstrainedWidth: wid,
                                              font: UIFont.font(size: HelperUtils.isPad ? 23 : 14, weight: .regular))
        return heiText + 16 // 16: padding top + bottom
    }
}

extension PopularPeopleTbvCell : UICollectionViewDelegate,
                                UICollectionViewDataSource,
                                UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.contentData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FVPageActorCell.nibName, for: indexPath) as? FVPageActorCell {
            let data = self.contentData[indexPath.row]
            cell.lblActor.text = data.name
            if self.isOnelineActorName {
                cell.lblActor.numberOfLines = 1
            }
            
            /** `Avatar` */
            if let imgUrl = URL(string: HelperUtils.getImageLink(url: data.profilePath ?? "")) {
                cell.imgActor.sd_setImage(with: imgUrl,
                                          placeholderImage: UIImage(named: BaseImage.Search.person))
            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size    = collectionView.frame.size
        let width   = size.width / 4
        return CGSize(width: width, height: width + self.getHeiOfCell(wid: width))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
}

