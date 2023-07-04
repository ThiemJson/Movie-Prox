//
//  Doule+Extension.swift
//  movie
//
//  Created by Macbook Pro 2017 on 7/13/20.
//  Copyright © 2020 Shantaram K. All rights reserved.
//

import Foundation
import UIKit
extension Double {
    func roundedToOneDecimalPlace() -> Double {
        let roundedNumber = (self * 10).rounded() / 10
        return roundedNumber
    }
    
    func getDateStringFromUTC() -> String {
        let date = Date(milliseconds: Int64(self))

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"

        return dateFormatter.string(from: date)
    }
    
    func convertDoubleToString() ->String {
        
        let numberFormatter = NumberFormatter()
        numberFormatter.minimumFractionDigits = 0 // default
        let numberString = numberFormatter.string(from: NSNumber(value: self)) ?? ""
        
        return numberString
    }
}
