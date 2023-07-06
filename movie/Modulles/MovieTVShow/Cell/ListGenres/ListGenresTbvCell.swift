//
//  ListGenresTbvCell.swift
//  movie
//
//  Created by ThiemJason on 05/07/2023.
//

import UIKit

class ListGenresTbvCell: UITableViewCell {
    static let nibName = "ListGenresTbvCell"
    @IBOutlet weak var clvContent: UICollectionView!
    
    var contentData = [Genre] () {
        didSet {
            DispatchQueue.main.async {
                self.clvContent.reloadData()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.initClv()
    }
    
    private func initClv() {
        self.clvContent.showsVerticalScrollIndicator    = false
        self.clvContent.showsHorizontalScrollIndicator  = false
        self.clvContent.dataSource      = self
        self.clvContent.delegate        = self
        
        let cell = UINib(nibName: GenresClvCell.nibName, bundle: nil)
        self.clvContent.register(cell, forCellWithReuseIdentifier: GenresClvCell.nibName)
        
        let contentInset = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 0)
        self.clvContent.contentInset = contentInset
    }
}

extension ListGenresTbvCell : UICollectionViewDelegate,
                              UICollectionViewDataSource,
                              UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.contentData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let data = self.contentData[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenresClvCell.nibName, for: indexPath) as! GenresClvCell
        
        if indexPath.item == 0 {
            cell.lblContent.font = UIFont.font(size: HelperUtils.isPad ? 18 : 16, weight: .bold)
            cell.lblContent.textColor = .rgb(0x263939)
            cell.lblContent.text = data.name
            cell.lblContent.makeUnderline()
        } else {
            cell.lblContent.font = UIFont.font(size: HelperUtils.isPad ? 16 : 14, weight: .regular)
            cell.lblContent.textColor = .rgb(0x7A7A7A)
            cell.lblContent.attributedText = NSAttributedString(string: data.name ?? "")
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let data = self.contentData[indexPath.item]
        if let name = data.name {
            let wid = name.getWidth(withFont: UIFont.font(size: HelperUtils.isPad ? 18 : 16, weight: .bold))
            return CGSize(width: wid * 1.1, height: collectionView.frame.height)
        }
        return CGSize(width: 40, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
