//
//  BaseFont.swift
//  movie-buff
//
//  Created by Prox on 27/04/2023.
//  Copyright © 2023 Prox. All rights reserved.
//

import Foundation
import UIKit

struct BaseFont {
    
    struct System {
        static var text_ulltrathin : UIFont     { UIFont.systemFont(ofSize: HelperUtils.isPad ? 16 : 14, weight: .ultraLight) }
        static var text_thin : UIFont           { UIFont.systemFont(ofSize: HelperUtils.isPad ? 16 : 14, weight: .thin) }
        static var text_regular_subcr : UIFont  { UIFont.systemFont(ofSize: HelperUtils.isPad ? 14 : 12, weight: .regular) }
        static var text_regular : UIFont        { UIFont.systemFont(ofSize: HelperUtils.isPad ? 16 : 14, weight: .regular) }
        static var text_semibold : UIFont       { UIFont.systemFont(ofSize: HelperUtils.isPad ? 16 : 14, weight: .semibold) }
        static var text_bold : UIFont           { UIFont.systemFont(ofSize: HelperUtils.isPad ? 16 : 14, weight: .bold) }
        static var text_heavy : UIFont          { UIFont.systemFont(ofSize: HelperUtils.isPad ? 16 : 14, weight: .heavy) }
    }
    
    struct Libre {
        struct Chart {
            static var label : UIFont           { UIFont.font(size: UIFont.baseFontSize + (HelperUtils.isPad ? 2 : 0), weight: .regular) }
        }
        
        struct Button {
            static var title : UIFont           { UIFont.font(size: UIFont.baseFontSize + (HelperUtils.isPad ? 4 : 2), weight: .semibold) }
        }
        
        struct Cell {
            static var title : UIFont           { UIFont.font(size: UIFont.baseFontSize + (HelperUtils.isPad ? 6 : 4), weight: .semibold) }
            static var caption : UIFont         { UIFont.font(size: UIFont.baseFontSize + (HelperUtils.isPad ? 2 : 0), weight: .regular) }
            static var smallCaption : UIFont    { UIFont.font(size: UIFont.baseFontSize - (HelperUtils.isPad ? 0 : 2), weight: .regular) }
        }
        
        struct CardView {
            static var cardTitle: UIFont        { UIFont.font(size: UIFont.baseFontSize + (HelperUtils.isPad ? 6 : 4), weight: .semibold) }
            static var contentTitle: UIFont     { UIFont.font(size: UIFont.baseFontSize + (HelperUtils.isPad ? 6 : 4), weight: .semibold) }
            static var contentSub: UIFont       { UIFont.font(size: UIFont.baseFontSize - (HelperUtils.isPad ? 0 : 2), weight: .medium) }
            static var note: UIFont             { UIFont.font(size: UIFont.baseFontSize + (HelperUtils.isPad ? 3 : 1), weight: .regular) }
            static var subNote: UIFont          { UIFont.font(size: UIFont.baseFontSize + (HelperUtils.isPad ? 2 : 1), weight: .regular) }
        }
    }
    
    struct Mono {}
}


extension UIFont {
    static let baseFontSize: CGFloat = 14
    
    static func font(size: CGFloat, weight: UIFont.Weight) -> UIFont {
        var traits = [UIFontDescriptor.TraitKey: Any]()
        traits[.weight] = weight
        
        var attributes = [UIFontDescriptor.AttributeName: Any]()
        attributes[.name] = nil
        attributes[.traits] = traits
        //attributes[.family] = "Libre Franklin"
        attributes[.family] = "Noto Serif"
        let descriptor = UIFontDescriptor(fontAttributes: attributes)
        
        return UIFont(descriptor: descriptor, size: size)
    }
    
    static func fontGochi(size: CGFloat, weight: UIFont.Weight) -> UIFont {
        var traits = [UIFontDescriptor.TraitKey: Any]()
        traits[.weight] = weight
        
        var attributes = [UIFontDescriptor.AttributeName: Any]()
        attributes[.name] = nil
        attributes[.traits] = traits
        attributes[.family] = "Gochi Hand"
        let descriptor = UIFontDescriptor(fontAttributes: attributes)
        
        return UIFont(descriptor: descriptor, size: size)
    }
    
    static func fontInter(size: CGFloat, weight: UIFont.Weight) -> UIFont {
        var traits = [UIFontDescriptor.TraitKey: Any]()
        traits[.weight] = weight
        
        var attributes = [UIFontDescriptor.AttributeName: Any]()
        attributes[.name] = nil
        attributes[.traits] = traits
        attributes[.family] = "Inter"
        let descriptor = UIFontDescriptor(fontAttributes: attributes)
        
        return UIFont(descriptor: descriptor, size: size)
    }
    
    static func fontInriaSerif(size: CGFloat, weight: UIFont.Weight) -> UIFont {
        var traits = [UIFontDescriptor.TraitKey: Any]()
        traits[.weight] = weight
        
        var attributes = [UIFontDescriptor.AttributeName: Any]()
        attributes[.name] = nil
        attributes[.traits] = traits
        attributes[.family] = "Inria Serif"
        let descriptor = UIFontDescriptor(fontAttributes: attributes)
        
        return UIFont(descriptor: descriptor, size: size)
    }
    
    static func fontPoppins(size: CGFloat, weight: UIFont.Weight) -> UIFont {
        var traits = [UIFontDescriptor.TraitKey: Any]()
        traits[.weight] = weight
        
        var attributes = [UIFontDescriptor.AttributeName: Any]()
        attributes[.name] = nil
        attributes[.traits] = traits
        attributes[.family] = "Poppins"
        let descriptor = UIFontDescriptor(fontAttributes: attributes)
        
        return UIFont(descriptor: descriptor, size: size)
    }
    
    static func fontRoboto(size: CGFloat, weight: UIFont.Weight) -> UIFont {
        var traits = [UIFontDescriptor.TraitKey: Any]()
        traits[.weight] = weight
        
        var attributes = [UIFontDescriptor.AttributeName: Any]()
        attributes[.name] = nil
        attributes[.traits] = traits
        attributes[.family] = "Roboto"
        let descriptor = UIFontDescriptor(fontAttributes: attributes)
        
        return UIFont(descriptor: descriptor, size: size)
    }
    
    //    static func regularFont(size: CGFloat) -> UIFont {
    //        let descriptor = UIFontDescriptor(name: "OpenSans-Regular", size: size)
    //        return UIFont(name: "OpenSans-Regular", size: size) ?? .systemFont(ofSize: size, weight: .regular)
    //    }
    //
    //    static func boldFont(size: CGFloat) -> UIFont {
    //        return UIFont(name: "OpenSans-Bold", size: size) ?? .systemFont(ofSize: size, weight: .bold)
    //    }
    //
    //    static func italicFont(size: CGFloat) -> UIFont {
    //        return UIFont(name: "OpenSans-Italic", size: size) ?? .italicSystemFont(ofSize: size)
    //    }
    
    /**
     Text hiển thị nội dung bình thường
     
     - returns
     Size: 14
     Weight: regular
     */
    static var normal: UIFont {
        return .font(size: baseFontSize, weight: .regular)
    }
    
    /**
     Text hiển thị Button
     
     - returns
     Size: 14
     Weight: medium
     */
    static var medium: UIFont {
        return .font(size: baseFontSize, weight: .medium)
    }
    
    /**
     Hiển thị ở các Header view
     
     - returns
     Size: 16
     Weight: regular
     */
    static var header: UIFont {
        return .font(size: baseFontSize + 2, weight: .regular)
    }
    
    /**
     Hiển thị ở các Header view
     
     - returns
     Size: 16
     Weight: medium
     */
    static var mediumHeader: UIFont {
        return .font(size: baseFontSize + 2, weight: .medium)
    }
    
    /**
     Hiển thị ở các Header view
     
     - returns
     Size: 18
     Weight: regular
     */
    static var title: UIFont {
        return .font(size: baseFontSize + 4, weight: .regular)
    }
    
    /**
     Hiển thị ở các Title Screen,..
     
     - returns
     Size: 18
     Weight: medium
     */
    static var mediumTitle: UIFont {
        return .font(size: baseFontSize + 4, weight: .medium)
    }
    
    /**
     Text hiển thị mô tả/caption
     
     - returns
     Size: 12
     Weight: medium
     */
    static var mediumCaption: UIFont {
        return .font(size: baseFontSize - 2, weight: .medium)
    }
    
    /**
     
     - returns
     Size: 20
     Weight: medium
     */
    static var mediumLargeTitle: UIFont {
        return .font(size: baseFontSize + 6, weight: .medium)
    }
}
