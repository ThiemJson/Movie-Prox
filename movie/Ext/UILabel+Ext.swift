//
//  UILabel+Extensions.swift
//  movie
//
//  Created by Prox on 16/03/2023.
//  Copyright © 2023 Prox. All rights reserved.
//

import UIKit

extension UILabel {
    @discardableResult
    func text(_ text: String?) -> Self {
        self.text = text
        return self
    }
    
    @discardableResult
    func font(_ font: UIFont?) -> Self {
        self.font = font
        return self
    }
    
    @discardableResult
    func color(_ color: UIColor?) -> Self {
        self.textColor = color
        return self
    }
    
    @discardableResult
    func alignment(_ alignment: NSTextAlignment) -> Self {
        self.textAlignment = alignment
        return self
    }
    
    @discardableResult
    func numberOfLines(_ line: Int) -> Self {
        self.numberOfLines = line
        return self
    }
    
    func makeUnderline(spacing: CGFloat = 4.0) {
        guard let labelText = text else { return }
        
        let attributedString = NSMutableAttributedString(string: labelText)
        
        // Add underline style
        attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: attributedString.length))
        
        // Set underline color
        attributedString.addAttribute(.underlineColor, value: self.textColor ?? .white.withAlphaComponent(0.4), range: NSRange(location: 0, length: attributedString.length))
        
        // Adjust baseline offset to create spacing
        attributedString.addAttribute(.baselineOffset, value: spacing, range: NSRange(location: 0, length: attributedString.length))
        
        attributedText = attributedString
    }
}
