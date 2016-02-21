//
//  UCSplashPieceLayer.swift
//  Underchess
//
//  Created by Apollonian on 16/2/15.
//  Copyright © 2016年 WWITDC. All rights reserved.
//

import UIKit

class UCSplashPieceLayer: CAShapeLayer {
    
    var color = UIColor.randomColor()
    var percentage = CGFloat(arc4random_uniform(101))
    var initialCenter = CGPointMake(0, 0)
    var finalCenter = CGPointMake(0, 0)
    
    var initialPath : UIBezierPath {
        return UIBezierPath(ovalInRect: CGRect(origin: initialCenter, size: CGSizeMake(0,0)))
    }
    
    var finalPath : UIBezierPath {
        let sideLength = min(frame.width, frame.height) * percentage / 100
        return UIBezierPath(ovalInRect:
            CGRect(
                origin: CGPointMake((finalCenter.x - sideLength) / 2, (finalCenter.y - sideLength) / 2),
                size: CGSizeMake(sideLength, sideLength)
            )
        )
    }
    
    
    
    func animate(){
        fillColor = color.CGColor
        let expandAnimation: CABasicAnimation = CABasicAnimation(keyPath: "path")
        expandAnimation.fromValue = initialPath.CGPath
        expandAnimation.toValue = finalPath.CGPath
        expandAnimation.duration = 1
        expandAnimation.fillMode = kCAFillModeForwards
        expandAnimation.removedOnCompletion = false
        addAnimation(expandAnimation, forKey: nil)
    }
}
