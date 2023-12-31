//
//  BaseColor.swift
//  movie
//
//  Created by Prox on 24/04/2023.
//

import Foundation
import UIKit

extension UIColor {
    static var primary: UIColor {
        return UIColor(named: "Primary") ?? #colorLiteral(red: 0.1764705882, green: 0.4549019608, blue: 0.9058823529, alpha: 1)
    }
    
    static var background: UIColor {
        return UIColor(named: "Background") ?? #colorLiteral(red: 0.9450980392, green: 0.9607843137, blue: 0.9882352941, alpha: 1)
    }
    
    static var textPrimary: UIColor {
        return UIColor(named: "Text Primary") ?? .rgb(0x1E2C2C)
    }
    
    static var textSecondary: UIColor {
        return UIColor(named: "Text Secondary") ?? #colorLiteral(red: 0.1490196078, green: 0.1843137255, blue: 0.231372549, alpha: 1)
    }
    
    static var textGray: UIColor {
        return UIColor(named: "Text Gray") ?? #colorLiteral(red: 0.5450980392, green: 0.6117647059, blue: 0.6980392157, alpha: 1)
    }
    
    static var red: UIColor {
        return UIColor(named: "Red") ?? #colorLiteral(red: 0.937254902, green: 0.262745098, blue: 0.2666666667, alpha: 1)
    }
    
    static var green: UIColor {
        return UIColor(named: "Green") ?? #colorLiteral(red: 0.1607843137, green: 0.8, blue: 0.568627451, alpha: 1)
    }
    
    static var line: UIColor {
        return UIColor(named: "Line") ?? #colorLiteral(red: 1, green: 0.9999999404, blue: 0.9999999404, alpha: 1)
    }
    
    static var disabled: UIColor {
        return UIColor(named: "Disabled") ?? .rgb(0xBFCAD9)
    }
    
    static var baseOrange: UIColor {
        return UIColor(named: "orange") ?? .rgb(0xff8c05)
    }
    
    static var gray100: UIColor {
        return UIColor(named: "gray100") ?? .rgb(0x2c2c2d)
    }
    
    static var baseBackground: UIColor {
        return UIColor(named: "baseBackground") ?? .rgb(0xFEFEFE)
    }
    
    static var tabbarBackground: UIColor {
        return UIColor(named: "tabbarBackground") ?? .rgb(0x2c2c2c)
    }
}
