//
//  UIView+Extension.swift
//  movie
//
//  Created by Macbook Pro 2017 on 8/4/20.
//  Copyright © 2023 BaseProject. All rights reserved.
//

import UIKit
import AVFoundation

extension UIView {
    func rotateImage180DegreesWithAnimation(_ imageView: UIImageView, completion: (() -> Void)?) {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.fromValue = 0.0
        rotationAnimation.toValue = CGFloat.pi // 180 degrees in radians
        rotationAnimation.duration = 0.3 // Adjust the duration as needed
        rotationAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            completion?()
        }
        imageView.layer.add(rotationAnimation, forKey: "rotationAnimation")
        CATransaction.commit()
    }
    
    func shiftImageCenter(_ imageView: UIImageView, shiftAmount: CGFloat) {
        guard let image = imageView.image else {
            return
        }
        
        let imageSize = image.size
        let viewSize = imageView.bounds.size
        
        let targetRect = CGRect(x: 0, y: shiftAmount, width: viewSize.width, height: viewSize.height - shiftAmount)
        let aspectFitSize = AVMakeRect(aspectRatio: imageSize, insideRect: targetRect).size
        
        //let xTranslation = (viewSize.width - aspectFitSize.width) / 2
        let yTranslation = (viewSize.height - aspectFitSize.height) / 2
        
        let translationTransform = CGAffineTransform(translationX: 0, y: yTranslation)
        
        imageView.transform = CGAffineTransform.identity
        imageView.frame = targetRect
        imageView.transform = translationTransform
    }
    
    func rotateImage180Degrees(_ image: UIImage) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(image.size, false, image.scale)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        
        // Flip the context to draw the image upside down
        context.translateBy(x: image.size.width / 2, y: image.size.height / 2)
        context.rotate(by: CGFloat.pi)
        context.scaleBy(x: -1.0, y: 1.0)
        context.translateBy(x: -image.size.width / 2, y: -image.size.height / 2)
        
        // Draw the image rotated
        image.draw(in: CGRect(origin: .zero, size: image.size))
        
        let rotatedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return rotatedImage
    }
    
    func takeScreenshot() -> UIImage {
        
        //begin
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)
        
        // draw view in that context.
        drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        
        // get iamge
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        if image != nil {
            return image!
        }
        
        return UIImage()
        
    }
    
    @discardableResult
    func dropShadow() -> UIView {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.12
        layer.shadowOffset = CGSize(width: 0, height: 1)
//        layer.shadowRadius = 5
        
        return self
    }
    
    func addShadowToView(shadowRadius: CGFloat = 2, alphaComponent: CGFloat = 0.6) {
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: alphaComponent).cgColor
        self.layer.shadowOffset = CGSize(width: -1, height: 2)
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOpacity = 1
    }
    
    func setShadowRadiusView(_ radius: CGFloat? = 14) {
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
        self.layer.shadowOffset = CGSize(width: 2, height: 5)
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.8
        self.layer.masksToBounds = false
        self.layer.cornerRadius =  radius ?? 14
    }
    
    func removeSetShadowRadiusView() {
        self.layer.shadowColor = UIColor.white.cgColor
        self.layer.shadowOffset = CGSize(width: 2, height: 5)
        self.layer.shadowRadius = 0
        self.layer.shadowOpacity = 1
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 0
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func removeShadow(){
        self.layer.shadowColor = UIColor.white.cgColor
        
    }
    
    func setShadowBotView() {
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
        self.layer.shadowOffset = CGSize(width: 2, height: -5)
        self.layer.shadowRadius = 2
        self.layer.shadowOpacity = 0.2
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 30
    }
    
    func setShadowBottom() {
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 2
        self.layer.shadowOpacity = 1
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0 , height:2)
    }
    
    func setBorderView() {
        self.backgroundColor = .clear
        self.layer.borderWidth = 1
        self.layer.borderColor = Constant.Color.gray_text_opa.cgColor
        self.layer.cornerRadius = self.frame.height/2
    }
    
    func restoreMaskedCorners() {
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]
    }
    
    class func fromNib<T: UIView>() -> T {
        return Bundle(for: T.self).loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}


extension UIView {

func fadeIn(duration: TimeInterval = 0.5, delay: TimeInterval = 0.0, completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in }) {
    self.alpha = 0.0

    UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
        self.isHidden = false
        self.alpha = 1.0
    }, completion: completion)
}

    func toImage() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(bounds.size, isOpaque, 0.0)
        defer { UIGraphicsEndImageContext() }
        
        if let context = UIGraphicsGetCurrentContext() {
            layer.render(in: context)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            return image
        }
        
        return nil
    }
    
func fadeOut(duration: TimeInterval = 0.5, delay: TimeInterval = 0.0, completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in }) {
    self.alpha = 1.0

    UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
        self.alpha = 0.0
    }) { (completed) in
        self.isHidden = true
        completion(true)
    }
}
}

extension UIView {
    public var viewWidth: CGFloat {
        return self.frame.size.width
    }

    public var viewHeight: CGFloat {
        return self.frame.size.height
    }
}

extension UIView {
    /// Remove allSubView in view
    func removeAllSubViews() {
        self.subviews.forEach({ $0.removeFromSuperview() })
    }

}

extension UIView {
    func drawDashedLine(start: CGPoint, end: CGPoint, color: UIColor = .lightGray, width: CGFloat = 1, pattern: [NSNumber] = [2, 2]) -> CAShapeLayer {
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = width
        shapeLayer.lineDashPattern = pattern
        
        let path = CGMutablePath()
        path.addLines(between: [start, end])
        shapeLayer.path = path
        layer.addSublayer(shapeLayer)
        
        return shapeLayer
    }
}

extension UIImage {
    func flippedHorizontally() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        let context = UIGraphicsGetCurrentContext()
        context?.scaleBy(x: -1.0, y: 1.0)
        context?.translateBy(x: -size.width, y: 0)
        draw(in: CGRect(origin: .zero, size: size))
        let flippedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return flippedImage
    }
}

extension UIImageView {
    func rotateImage(byDegrees degrees: CGFloat) {
        let angle = degrees * .pi / 180.0 // Chuyển đổi từ độ sang radian

        // Tạo một bản sao của hình ảnh gốc
        guard let image = self.image?.cgImage else { return }
        let rotatedImage = UIImage(cgImage: image)

        // Xoay hình ảnh bằng CGAffineTransform
        let rotatedImageView = UIImageView(image: rotatedImage)
        rotatedImageView.frame = self.bounds
        rotatedImageView.transform = CGAffineTransform(rotationAngle: angle)

        // Xoá các subview của UIImageView
        self.subviews.forEach { $0.removeFromSuperview() }

        // Thêm rotatedImageView làm subview mới
        self.addSubview(rotatedImageView)
    }
}
