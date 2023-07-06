//
//  ListMovieTbvCell.swift
//  movie-buff
//
//  Created by Prox on 07/05/2023.
//  Copyright © 2023 Prox. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import FSPagerView
import SDWebImage

class ListMovieTbvCell: UITableViewCell {
    static let nibName = "ListMovieTbvCell"
    @IBOutlet weak var vContentView     : UIView!
    @IBOutlet weak var fsPagerView      : FSPagerView!
    @IBOutlet weak var fsPageControl    : FSPageControl!
    
    var type: MovieTVShowType           = .Movie
    var contentData                     = [Any]() {
        didSet {
            DispatchQueue.main.async {
                self.fsPagerView.reloadData()
                self.fsPageControl.currentPage      = 0
                self.fsPageControl.numberOfPages    = self.contentData.count
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupClv()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setupClv() {
        let cell    = UINib(nibName: ListMovieContentCell.nibName, bundle: nil)
        self.fsPagerView.register(cell, forCellWithReuseIdentifier: "cell")
        
        /** `Pager view` */
        self.fsPagerView.delegate                   = self
        self.fsPagerView.dataSource                 = self
        self.fsPagerView.automaticSlidingInterval   = 3.0
        self.fsPagerView.isInfinite                 = true
        self.fsPagerView.interitemSpacing           = 10
        let transformer                             = FSPagerViewTransformer(type: .linear)
        transformer.minimumAlpha                    = 0.1
        transformer.minimumScale                    = 0.8
        self.fsPagerView.transformer                = transformer
        
        /** `Page control` */
        self.fsPageControl.numberOfPages            = self.contentData.count
        self.fsPageControl.itemSpacing             = 14
        self.fsPageControl.interitemSpacing        = 12
        self.fsPageControl.setImage(UIImage(named:"ic_fspage_contro_un"), for: .normal)
        self.fsPageControl.setImage(UIImage(named:"ic_fspage_contro_select"), for: .selected)
    }
}

/** `FSPager` */
extension ListMovieTbvCell: FSPagerViewDelegate, FSPagerViewDataSource {
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return self.contentData.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index) as! ListMovieContentCell
        cell.delegate   = self
        let data = self.contentData[index]
        cell.data   = data
        
        var imgURL  = ""
        var avtURL  = ""
        var sub     = ""
        
        /** `Movie` */
        if let dataMovie = data as? MovieModelData {
            imgURL      = HelperUtils.getImageLink(url: dataMovie.backdropPath ?? "")
            avtURL      = HelperUtils.getImageLink(url: dataMovie.posterPath ?? "")
            let date    = (dataMovie.releaseDate ?? "").prefix(4)
            sub         = HelperUtils.getSubFromDateAndGenres(date: date.description, genres: Array(dataMovie.genresID.prefix(3)))
            cell.lblName.text = dataMovie.title ?? dataMovie.originalTitle
        }
        
        /** `TVShow` */
        if let dataMovie = data as? TVShowModelData {
            imgURL      = HelperUtils.getImageLink(url: dataMovie.backdropPath ?? "")
            avtURL      = HelperUtils.getImageLink(url: dataMovie.posterPath ?? "")
            let date    = (dataMovie.firstAirDate ?? "").prefix(4)
            sub         = HelperUtils.getSubFromDateAndGenres(date: date.description, genres: Array(dataMovie.genresID.prefix(3)))
            cell.lblName.text = dataMovie.name ?? dataMovie.originalName
        }
        
        
        cell.lblSub.text    = sub
        if let imgUrl = URL(string: imgURL) {
            cell.imgContent.sd_setImage(with: imgUrl,
                                        placeholderImage: UIImage(named: BaseImage.Search.movie))
        }
        if let avtUrl = URL(string: avtURL) {
            cell.imgAvt.sd_setImage(with: avtUrl,
                                    placeholderImage: UIImage(named: BaseImage.Search.movieHori))
        }
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, willDisplay cell: FSPagerViewCell, forItemAt index: Int) {
        self.fsPageControl.currentPage  = index
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        //        let viewModel   = DetailMovieTVShowsVMObject(data: self.contentData[index])
        //        let detailVC    = DetailMovieTVShowsVC(viewModel)
        //        detailVC.type   = self.type
        //        detailVC.hidesBottomBarWhenPushed   = true
        //        AdsService.shared.requestInterstitialAds(vc: detailVC)
    }
}

extension ListMovieTbvCell : ListMovieContentCellDelegate {
    func didSelectShowDetail(data: Any?) {
        if let data = data {
            //            let viewModel   = DetailMovieTVShowsVMObject(data: data)
            //            let detailVC    = DetailMovieTVShowsVC(viewModel)
            //            detailVC.type   = self.type
            //            detailVC.hidesBottomBarWhenPushed   = true
            //            AdsService.shared.requestInterstitialAds(vc: detailVC)
        }
    }
    
    func didSelectPlay(data: Any?) {
        /** `Movie` */
        if
            let dataMovie = data as? MovieModelData {
            var query = BaseQuery()
            query.append_to_response    = "videos,credits,recommendations"
            MoviesService.get_movieDetail(query: query, id: dataMovie.id ?? 0)
                .onSuccess { [weak self] (model) in
                    guard
                        let `self`  = self,
                        let videos  = model.videos?.results.filter({ model in
                            return model.type == "Trailer"
                        }).first
                    else {
                        DispatchQueue.main.async {
                            AppMessagesManager.shared.showMessage(messageType: .error, message: "No data found")
                        }
                        return
                    }
                    //                    let previewVC                   = PlayerPreviewVC(PlayerPreviewVMObject())
                    //                    previewVC.isFromMovieTrailer    = true
                    //                    previewVC.mediaData             = dataMovie
                    //                    previewVC.ratio                 = .backdrop
                    //                    previewVC.videoResult           = videos
                    //
                    //                    let date    = (model.releaseDate ?? "").prefix(4)
                    //                    let sub     = HelperUtils.getSubFromDateAndGenres(date: date.description, genres: Array(model.genresID.prefix(3)))
                    //                    previewVC.subtitile             = sub
                    //                    previewVC.hidesBottomBarWhenPushed  = true
                    //                    previewVC.push()
                }
        }
        
        /** `TVShow` */
        if
            let dataTVShow = data as? TVShowModelData {
            var query = BaseQuery()
            query.append_to_response    = "videos,credits,recommendations"
            TVShowsService.get_tvDetail(query: query, id: dataTVShow.id ?? 0)
                .onSuccess { [weak self] (model) in
                    guard
                        let `self`  = self,
                        let videos  = model.videos?.results.filter({ model in
                            return model.type == "Trailer"
                        }).first
                    else {
                        DispatchQueue.main.async {
                            AppMessagesManager.shared.showMessage(messageType: .error, message: "No data found")
                        }
                        return
                    }
                    //                    let previewVC                   = PlayerPreviewVC(PlayerPreviewVMObject())
                    //                    previewVC.isFromMovieTrailer    = true
                    //                    previewVC.ratio                 = .backdrop
                    //                    previewVC.mediaData             = dataTVShow
                    //                    previewVC.videoResult           = videos
                    //
                    //                    let date    = (model.firstAirDate ?? "").prefix(4)
                    //                    let sub     = HelperUtils.getSubFromDateAndGenres(date: date.description, genres: Array(model.genresID.prefix(3)))
                    //                    previewVC.subtitile             = sub
                    //                    previewVC.hidesBottomBarWhenPushed  = true
                    //                    previewVC.push()
                }
        }
    }
}
