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
    
    var initialPath : UIBezierPath {
        return UIBezierPath(ovalInRect: CGRectMake(frame.width / 2, frame.height / 2,0,0))
    }
    
    var finalPath : UIBezierPath {
        let sideLength = min(frame.width, frame.height) * percentage / 100
        return UIBezierPath(ovalInRect:
            CGRect(
                origin: CGPointMake((frame.width - sideLength) / 2, (frame.height - sideLength) / 2),
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
