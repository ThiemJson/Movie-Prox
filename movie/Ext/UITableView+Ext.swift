//
//  UITableView+Extension.swift
//  movie-buff
//
//  Created by Prox on 27/04/2023.
//  Copyright © 2023 Prox. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    func initDefault() {
        self.separatorStyle     = .none
        self.contentInset       = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        self.showsVerticalScrollIndicator   = false
        self.showsHorizontalScrollIndicator = false
    }
    
    func appearTopToBottom() {
        self.frame = CGRect(x: 0, y: -self.frame.height, width: self.frame.width, height: self.frame.height)
        UIView.animate(withDuration: 0.5) {
            self.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        }
    }
    
    func disappearBottomToTop(completion: @escaping ((_: Bool) -> Void) ) {
        UIView.animate(withDuration: 0.5, animations: {
            self.superview?.frame.origin.y = self.superview?.bounds.height ?? 0
            self.alpha = 0
        }, completion: completion)
    }
}
