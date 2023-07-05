//
//  MovieTVShowVC.swift
//  movie
//
//  Created by ThiemJason on 05/07/2023.
//

import UIKit
import RxSwift
import RxCocoa
import ViewAnimator

enum MovieTVShowType {
    case Movie
    case TVShow
}

enum MovieTVShowDashBoardCellType {
    case ListMovie
    case TopView
    //case Ads
    case NewMovie
    case PopularPeople
}

class MovieTVShowVC: BaseViewModelController<MovieTVShowVM> {
    @IBOutlet weak var vNavBar              : NavBar!
    @IBOutlet weak var tbvContent           : UITableView!
    
    static var GENRES               = [Int : Genre]()
    
    /** `Genres` */
    let normalFont                  = UIFont.font(size: HelperUtils.isPad ? 20 : 18, weight: .medium)
    let normalColor                 = Constant.Color.hex_7A7A7A
    let selectedFont                = UIFont.font(size: HelperUtils.isPad ? 22 : 20, weight: .semibold)
    let selectedColor : UIColor     = .white
    var genresContentData           = [Genre]()
    var selectedGenres              : Genre?
    
    /** `Type` */
    var homeDashboardType : MovieTVShowType   = .Movie
    var dataContent : [MovieTVShowDashBoardCellType]   = [.ListMovie, .TopView, .NewMovie, .PopularPeople]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchData(type: self.homeDashboardType)
    }
    
    private func fetchData(type: MovieTVShowType) {
        guard let viewModel = self.viewModel else { return }
        
        BaseLoading.shared.show()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            BaseLoading.shared.dismiss()
        }
        
        /** `Movie` */
        if type == .Movie {
            var query   = BaseQuery()
            viewModel.getGenresMovie(query: query) { [weak self] (genres) in
                guard let `self` = self else { return }
                
                let listGenre = genres.genres
                self.selectedGenres = listGenre.first
                
                viewModel.getMoviePopular(query: query)
                viewModel.getMovieTopRated(query: query)
                viewModel.getMovieNewPlaying(query: query)
                
                /** `Movies page1` */
                query.page = 1
                viewModel.getActorPopular(query: query)
                return
            }
            return
        }
        
        /** `TV Shows` */
        var query   = BaseQuery()
        viewModel.getGenresTV(query: query) { [weak self] (genres) in
            guard let `self` = self else { return }
            
            let listGenre = genres.genres
            self.selectedGenres = listGenre.first
            
            viewModel.getTVPopular(query: query)
            viewModel.getTVTopRated(query: query)
            viewModel.getTVAiringToday(query: query)
            
            /** `Movies page1` */
            query.page = 2
            viewModel.getActorPopular(query: query)
            return
        }
    }
    
    private func reloadTBV( _ index: MovieTVShowDashBoardCellType) -> Void {
        if let index   = self.dataContent.firstIndex(of: index) {
            let indexPath   = IndexPath(row: index, section: 0)
            self.tbvContent.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    
    override func setupBinding() {
        super.setupBinding()
        guard let viewModel = self.viewModel else { return }
        
        /** `Movie` */
        viewModel.rx_Movies_Playing.asDriver().drive(onNext: { _ in self.reloadTBV(.ListMovie)}).disposed(by: self.rxDisposeBag)
        viewModel.rx_Movies_Popular.asDriver().drive(onNext: { _ in self.reloadTBV(.NewMovie)}).disposed(by: self.rxDisposeBag)
        viewModel.rx_Movies_TopRate.asDriver().drive(onNext: { _ in self.reloadTBV(.TopView)}).disposed(by: self.rxDisposeBag)
        
        /** `TVShow` */
        viewModel.rx_TVShow_Playing.asDriver().drive(onNext: { _ in self.reloadTBV(.ListMovie)}).disposed(by: self.rxDisposeBag)
        viewModel.rx_TVShow_Popular.asDriver().drive(onNext: { _ in self.reloadTBV(.NewMovie)}).disposed(by: self.rxDisposeBag)
        viewModel.rx_TVShow_TopRate.asDriver().drive(onNext: { _ in self.reloadTBV(.TopView)}).disposed(by: self.rxDisposeBag)
        
        /** `Actor` */
        viewModel.rx_Actor.asDriver().drive(onNext: { _ in self.reloadTBV(.PopularPeople)}).disposed(by: self.rxDisposeBag)
        
        
        /** `Error` */
        viewModel.rxError.asDriver().compactMap{ $0 }.drive(onNext: { [weak self] (error) in
            self?.showSnackError(message: error.json.description)
        }).disposed(by: self.rxDisposeBag)
        
        /** `Genres` */
        viewModel.rx_Genre.asDriver().drive(onNext: { [weak self] (response) in
            guard let `self` = self else { return }
            self.refreshControl.endRefreshing()
            response?.genres.forEach({ data in
                let id  = data.id
                MovieTVShowVC.GENRES.updateValue(data, forKey: id ?? 0)
            })
        }).disposed(by: self.rxDisposeBag)
    }
    
    override func setupUI() {
        super.setupUI()
        self.setupTableView()
    }
    
    override func setupNavBar() {
        super.setupNavBar()
        self.vNavBar.rxType.accept(.MoviesTVShow)
        self.vNavBar.imgRight.tintColor = .white
    }
    
    private func setupTableView() {
        self.tbvContent.initDefault()
        self.tbvContent.backgroundColor = .clear
        self.tbvContent.delegate        = self
        self.tbvContent.dataSource      = self
        self.tbvContent.contentInsetAdjustmentBehavior  = .never
        
        /** `Refresh control` */
        self.refreshControl.tintColor   = .white
        self.refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        self.tbvContent.addSubview(self.refreshControl)
        self.tbvContent.alwaysBounceVertical = true
        
        /** `Register` */
        let listGen   = UINib(nibName: ListGenresTbvCell.nibName, bundle: nil)
        self.tbvContent.register(listGen, forCellReuseIdentifier: ListGenresTbvCell.nibName)
        
        let listMovie = UINib(nibName: ListMovieTbvCell.nibName, bundle: nil)
        self.tbvContent.register(listMovie, forCellReuseIdentifier: ListMovieTbvCell.nibName)
        
        let topview   = UINib(nibName: TopViewTbvCell.nibName, bundle: nil)
        self.tbvContent.register(topview, forCellReuseIdentifier: TopViewTbvCell.nibName)
        
        let newmovie    = UINib(nibName: NewMovieTbvCell.nibName, bundle: nil)
        self.tbvContent.register(newmovie, forCellReuseIdentifier: NewMovieTbvCell.nibName)
        
        let popuplar = UINib(nibName: PopularPeopleTbvCell.nibName, bundle: nil)
        self.tbvContent.register(popuplar, forCellReuseIdentifier: PopularPeopleTbvCell.nibName)
    }
    
    override func handlerAction() {
        super.handlerAction()
        /** `NavBar` */
        /// Setting
        self.vNavBar.imgRight.rx.tap()
            .asObservable().onMain()
            .subscribe(onNext: { [weak self] _ in
                guard let `self` = self else { return }
                //                let settingVC                               = SettingDashboardVC(SettingDashboardVMObject())
                //                settingVC.hidesBottomBarWhenPushed          = true
                //                self.push(vc: settingVC)
            })
            .disposed(by: self.rxDisposeBag)
        
        /// Search
        self.vNavBar.imgRight2.rx.tap()
            .asObservable().onMain()
            .subscribe(onNext: { [weak self] _ in
                guard let `self` = self else { return }
                //                let searchVC    = SearchVC(SearchVMObject())
                //                searchVC.hidesBottomBarWhenPushed   = true
                //                AdsService.shared.requestInterstitialAds(vc: searchVC, isShowInstantly: true)
            })
            .disposed(by: self.rxDisposeBag)
        /** `--------------` */
    }
}

// MARK: API
extension MovieTVShowVC {
    @objc private func refresh(_ sender: AnyObject) {
        self.fetchData(type: self.homeDashboardType)
    }
}


// MARK: TabelView
extension MovieTVShowVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        /** `Animation từ segment trở đi` */
        if indexPath.row > 1 {
            //let fromAnim    = AnimationType.from(direction: .top, offset: 20)
            //UIView.animate(views: [cell], animations: [fromAnim], delay: 0.2, duration: 0.2)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataContent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch self.dataContent[indexPath.row] {
        case .ListMovie:
            if let cell = tableView.dequeueReusableCell(withIdentifier: ListMovieTbvCell.nibName, for: indexPath) as? ListMovieTbvCell {
                cell.selectionStyle = .none
                //                cell.type   = self.homeDashboardType
                //                if self.homeDashboardType == .Movie {
                //                    let data            = self.viewModel?.rx_Movies_Playing.value?.results ?? []
                //                    cell.contentData    = Array(data.prefix(5))
                //                } else {
                //                    let data            = self.viewModel?.rx_TVShow_Playing.value?.results ?? []
                //                    cell.contentData    = Array(data.prefix(5))
                //                }
                return cell
            }
        case .TopView:
            if let cell = tableView.dequeueReusableCell(withIdentifier: TopViewTbvCell.nibName, for: indexPath) as? TopViewTbvCell {
                cell.selectionStyle = .none
                //                cell.type       = self.homeDashboardType
                //                cell.tableview  = self.tbvContent
                //                if self.homeDashboardType == .Movie {
                //                    let data            = self.viewModel?.rx_Movies_TopRate.value?.results ?? []
                //                    cell.contentData    = Array(data.prefix(3))
                //                } else {
                //                    let data            = self.viewModel?.rx_TVShow_TopRate.value?.results ?? []
                //                    cell.contentData    = Array(data.prefix(3))
                //                }
                return cell
            }
        case .NewMovie:
            if let cell = tableView.dequeueReusableCell(withIdentifier: NewMovieTbvCell.nibName, for: indexPath) as? NewMovieTbvCell {
                //cell.type               = self.homeDashboardType
                cell.selectionStyle = .none
                //                if self.homeDashboardType == .Movie {
                //                    let data            = self.viewModel?.rx_Movies_Popular.value?.results ?? []
                //                    cell.contentData    = Array(data.prefix(5))
                //                    cell.lblTitle.text  = "New Movie"
                //                } else {
                //                    cell.lblTitle.text  = "New Movie"
                //                    let data            = self.viewModel?.rx_TVShow_Popular.value?.results ?? []
                //                    cell.contentData    = Array(data.prefix(5))
                //                }
                return cell
            }
        case .PopularPeople:
            if let cell = tableView.dequeueReusableCell(withIdentifier: PopularPeopleTbvCell.nibName, for: indexPath) as? PopularPeopleTbvCell {
                cell.selectionStyle = .none
                //                cell.contentData    = self.viewModel?.rx_Actor.value?.results ?? []
                //                cell.type           = self.homeDashboardType
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch self.dataContent[indexPath.row] {
        case .ListMovie:
            /** `Tỉ lệ 2:3` */
            return UIScreen.main.bounds.width * (3/2)
            //        case .Ads:
            //            let padding = (HelperUtils.isPad ? 16 : 8) * 2
            //            return CGFloat(UIScreen.main.bounds.width * (120 / 340) + CGFloat(padding))
        case .TopView:
            return UITableView.automaticDimension
        case .NewMovie:
            return UITableView.automaticDimension
        case .PopularPeople:
            return UITableView.automaticDimension
        }
    }
}
