//
//  NewMoviePagerCell.swift
//  movie-buff
//
//  Created by Prox on 5/16/23.
//  Copyright © 2023 Prox. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import FSPagerView

protocol SelectItemDelegate : NSObjectProtocol {
    func didSelectItem(_: Any?)
}

class TopViewTbvCell: UITableViewCell {
    static let nibName                  = "TopViewTbvCell"
    @IBOutlet weak var fsPagerView      : FSPagerView!
    @IBOutlet weak var constFSPageViewHeight: NSLayoutConstraint!
    @IBOutlet weak var lblTitle         : UILabel!
    @IBOutlet weak var lblMore          : UILabel!
    @IBOutlet weak var lblName          : UILabel!
    @IBOutlet weak var lblSub           : UILabel!
    
    var type        = MovieTVShowType.Movie
    var isFirstime  = true
    weak var delegate : SelectItemDelegate?
    var contentData : [Any] = [Any]() {
        didSet {
            DispatchQueue.main.async {
                self.fsPagerView.reloadData()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.setupUI()
    }
    
    private func setupUI() {
        self.fsPagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        
        self.lblTitle.font = UIFont.font(size: 16, weight: .semibold)
        self.lblTitle.textColor = .textPrimary
        
        self.lblMore.font = UIFont.font(size: 12, weight: .regular)
        self.lblMore.text = "See all"
        self.lblMore.makeUnderline()
        self.lblMore.textColor = .rgb(0x1E2C2C)
        
        self.lblName.font = UIFont.font(size: 12, weight: .semibold)
        self.lblName.textColor = .textPrimary
        
        self.lblSub.font = UIFont.font(size: 10, weight: .regular)
        self.lblSub.textColor = .rgb(0xC1C1C1)
        
        /** `Pager view` */
        let size    = UIScreen.main.bounds
        let itemWid = size.width * (124 / 377)
        let itemHei = itemWid * (3/2)
        self.constFSPageViewHeight.constant         = itemHei
        self.fsPagerView.itemSize                   = CGSize(width: itemWid, height: itemHei)
        self.fsPagerView.delegate                   = self
        self.fsPagerView.dataSource                 = self
        self.fsPagerView.interitemSpacing           = -4
        let transformer                             = NewMoviePagerViewTransformer(type: .overlap)
        transformer.minimumAlpha                    = 0.9
        transformer.minimumScale                    = 0.868
        self.fsPagerView.transformer                = transformer
    }
}

/** `FSPager` */
extension TopViewTbvCell: FSPagerViewDelegate, FSPagerViewDataSource {
    
    func pagerView(_ pagerView: FSPagerView, willDisplay cell: FSPagerViewCell, forItemAt index: Int) {
        if self.isFirstime {
            if self.contentData.isEmpty { return }
            if self.contentData.count >= 4 {
                self.isFirstime = false
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    self.fsPagerView.selectItem(at: 3, animated: true)
                }
            }
        }
    }
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return self.contentData.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        if index >= self.contentData.count { return cell }
        let data    = self.contentData[index]
        var imgURL  = ""
        if self.type == .Movie {
            if let dataMovie = data as? MovieModelData {
                imgURL      = HelperUtils.getImageLink(url: dataMovie.posterPath ?? "")
            }
        }
        
        if self.type == .TVShow {
            if let dataTVShow = data as? TVShowModelData {
                imgURL      = HelperUtils.getImageLink(url: dataTVShow.posterPath ?? "")
            }
        }
        
        if let url = URL(string: imgURL) {
            cell.imageView?.sd_setImage(with: url,
                                        placeholderImage: UIImage(named: BaseImage.Search.movie))
        }
        
        /** `Make border` */
        if let image = cell.imageView {
            image.layer.cornerRadius    = CGFloat(Constant.Values.commonRadius)
            image.clipsToBounds         = true
        }
        
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, shouldSelectItemAt index: Int) -> Bool {
        if pagerView.currentIndex   == index {
            self.delegate?.didSelectItem(self.contentData[index])
        }
        return true
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.selectItem(at: index, animated: true)
    }
    
    func pagerViewDidScroll(_ pagerView: FSPagerView) {
        let data  = self.contentData[self.fsPagerView.currentIndex]
        if self.type == .Movie {
            if let dataMovie = data as? MovieModelData {
                self.lblName.text = dataMovie.title ?? dataMovie.originalTitle
                let date = (dataMovie.releaseDate ?? "").prefix(4)
                let sub = HelperUtils.getSubFromDateAndGenres(date: date.description,
                                                              genres: Array(dataMovie.genresID.prefix(2)))
                self.lblSub.text = sub
            }
        }
        
        if self.type == .TVShow {
            if let dataTVShow = data as? TVShowModelData {
                self.lblName.text = dataTVShow.name ?? dataTVShow.originalName
                let date = (dataTVShow.firstAirDate ?? "").prefix(4)
                let sub = HelperUtils.getSubFromDateAndGenres(date: date.description,
                                                              genres: Array(dataTVShow.genresID.prefix(2)))
                self.lblSub.text = sub
            }
        }
    }
}
