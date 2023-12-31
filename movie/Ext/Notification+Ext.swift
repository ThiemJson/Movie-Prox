//
//  Notification+Extensions.swift
//  movie
//
//  Created by Prox on 20/03/2023.
//  Copyright © 2023 Prox. All rights reserved.
//

import UIKit

extension Notification {
    var keyboardAnimationDuration: TimeInterval? {
        if let duration = userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber {
            return duration.doubleValue
        }
        return nil
    }
    
    var keyboardHeight: CGFloat? {
        if let frame = userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            return frame.cgRectValue.height
        }
        return nil
    }
}
