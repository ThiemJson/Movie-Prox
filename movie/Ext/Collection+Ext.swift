//
//  Collection+Extension.swift
//  movie
//
//  Created by Macbook Pro 2017 on 1/5/21.
//  Copyright © 2021 Prox. All rights reserved.
//

import Foundation
import UIKit
extension Collection where Indices.Iterator.Element == Index {
   public subscript(safe index: Index) -> Iterator.Element? {
     return (startIndex <= index && index < endIndex) ? self[index] : nil
   }
}

