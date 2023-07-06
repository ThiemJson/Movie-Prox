//
//  GenresClvCell.swift
//  movie
//
//  Created by ThiemJason on 06/07/2023.
//

import UIKit

class GenresClvCell: UICollectionViewCell {
    static let nibName = "GenresClvCell"
    @IBOutlet weak var lblContent: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.lblContent.font    = UIFont.font(size: HelperUtils.isPad ? 18 : 16, weight: .bold)
    }
}
