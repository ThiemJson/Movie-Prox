//
//  FSPagerView+Extention.swift
//  movie-buff
//
//  Created by Prox on 5/20/23.
//  Copyright © 2023 Prox. All rights reserved.
//

import Foundation
import FSPagerView

class NewMoviePagerViewTransformer: FSPagerViewTransformer {
    
    open override func proposedInteritemSpacing() -> CGFloat {
        guard let pagerView = self.pagerView else {
            return 0
        }
        let scrollDirection = pagerView.scrollDirection
        switch self.type {
        case .overlap:
            guard scrollDirection == .horizontal else {
                return 0
            }
            return pagerView.itemSize.width * -self.minimumScale * 0.6
        case .linear:
            guard scrollDirection == .horizontal else {
                return pagerView.interitemSpacing
            }
            return pagerView.interitemSpacing
        case .coverFlow:
            guard scrollDirection == .horizontal else {
                return 0
            }
            return -pagerView.itemSize.width * sin(.pi*0.25*0.25*3.0)
        case .ferrisWheel,.invertedFerrisWheel:
            guard scrollDirection == .horizontal else {
                return 0
            }
            return -pagerView.itemSize.width * 0.15
        case .cubic:
            return 0
        default:
            break
        }
        return pagerView.interitemSpacing
    }
    
    override func applyTransform(to attributes: FSPagerViewLayoutAttributes) {
        guard let pagerView = self.pagerView else {
            return
        }
        let position = attributes.position
        let scrollDirection = pagerView.scrollDirection
        let itemSpacing = (scrollDirection == .horizontal ? attributes.bounds.width : attributes.bounds.height) + self.proposedInteritemSpacing()
        
        if self.type == .linear {
            guard scrollDirection == .horizontal else {
                // This type doesn't support vertical mode
                return
            }
            let scale = max(1 - (1-self.minimumScale) * abs(position), self.minimumScale)
            var transform = CGAffineTransform(scaleX: scale, y: scale)
            
            let translateY  = max(0, 1 - abs(position)) * 30
            //transform   = transform.translatedBy(x: 0, y: -(translateY - 18))
            
            attributes.transform = transform
            let alpha = (self.minimumAlpha + (1-abs(position))*(1-self.minimumAlpha))
            attributes.alpha = alpha
            let zIndex = (1-abs(position)) * 10
            attributes.zIndex = Int(zIndex)
            
        } else {
            super.applyTransform(to: attributes)
        }
    }
}

class CustomPagerViewTransformer: FSPagerViewTransformer {
    
    open override func proposedInteritemSpacing() -> CGFloat {
        guard let pagerView = self.pagerView else {
            return 0
        }
        let scrollDirection = pagerView.scrollDirection
        switch self.type {
        case .overlap:
            guard scrollDirection == .horizontal else {
                return 0
            }
            return pagerView.itemSize.width * -self.minimumScale * 0.6
        case .linear:
            guard scrollDirection == .horizontal else {
                return 0
            }
            return pagerView.interitemSpacing
        case .coverFlow:
            guard scrollDirection == .horizontal else {
                return 0
            }
            return -pagerView.itemSize.width * sin(.pi*0.25*0.25*3.0)
        case .ferrisWheel,.invertedFerrisWheel:
            guard scrollDirection == .horizontal else {
                return 0
            }
            return -pagerView.itemSize.width * 0.15
        case .cubic:
            return 0
        default:
            break
        }
        return pagerView.interitemSpacing
    }
    
    override func applyTransform(to attributes: FSPagerViewLayoutAttributes) {
        guard let pagerView = self.pagerView else {
            return
        }
        let position = attributes.position
        let scrollDirection = pagerView.scrollDirection
        let itemSpacing = (scrollDirection == .horizontal ? attributes.bounds.width : attributes.bounds.height) + self.proposedInteritemSpacing()
        
        if self.type == .linear {
            guard scrollDirection == .horizontal else {
                // This type doesn't support vertical mode
                return
            }
            let scale = max(1 - (1-self.minimumScale) * abs(position), self.minimumScale)
            let transform = CGAffineTransform(scaleX: scale, y: scale)
            attributes.transform = transform
            
            let alpha = (self.minimumAlpha + (1-abs(position))*(1-self.minimumAlpha))
            attributes.alpha = alpha
            let zIndex = (1-abs(position)) * 10
            attributes.zIndex = Int(zIndex)
            
        } else {
            super.applyTransform(to: attributes)
        }
    }
    
}

class MoviePagerViewTransformer: FSPagerViewTransformer {
    
    open override func proposedInteritemSpacing() -> CGFloat {
        guard let pagerView = self.pagerView else {
            return 0
        }
        let scrollDirection = pagerView.scrollDirection
        switch self.type {
        case .overlap:
            guard scrollDirection == .horizontal else {
                return 0
            }
            return pagerView.itemSize.width * -self.minimumScale * 0.6
        case .linear:
            guard scrollDirection == .horizontal else {
                return 0
            }
            return pagerView.interitemSpacing
        case .coverFlow:
            guard scrollDirection == .horizontal else {
                return 0
            }
            return -pagerView.itemSize.width * sin(.pi*0.25*0.25*3.0)
        case .ferrisWheel,.invertedFerrisWheel:
            guard scrollDirection == .horizontal else {
                return 0
            }
            return -pagerView.itemSize.width * 0.15
        case .cubic:
            return 0
        default:
            break
        }
        return pagerView.interitemSpacing
    }
    
    override func applyTransform(to attributes: FSPagerViewLayoutAttributes) {
        guard let pagerView = self.pagerView else {
            return
        }
        let position = attributes.position
        let scrollDirection = pagerView.scrollDirection
        let itemSpacing = (scrollDirection == .horizontal ? attributes.bounds.width : attributes.bounds.height) + self.proposedInteritemSpacing()
        
        if self.type == .linear {
            guard scrollDirection == .horizontal else {
                // This type doesn't support vertical mode
                return
            }
            let scale = max(1 - (1-self.minimumScale) * abs(position), self.minimumScale)
            var transform = CGAffineTransform(scaleX: scale, y: scale)
            let translateY  = max(0, abs(position)) * 15
            transform   = transform.translatedBy(x: 0, y: -(min(15, translateY)))
            
            attributes.transform = transform
            
            let alpha = (self.minimumAlpha + (1-abs(position))*(1-self.minimumAlpha))
            attributes.alpha = alpha
            let zIndex = (1-abs(position)) * 10
            attributes.zIndex = Int(zIndex)
            
        } else {
            super.applyTransform(to: attributes)
        }
    }
    
}
