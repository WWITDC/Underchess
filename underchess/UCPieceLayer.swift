//
//  UCPieceLayer.swift
//  Underchess
//
//  Created by Apollonian on 3/7/16.
//  Copyright © 2016 WWITDC. All rights reserved.
//

import UIKit

class UCPieceLayer: CAShapeLayer {
    init(fill: UIColor, stroke: UIColor, strokeWidth width: CGFloat, center: CGPoint, radius: CGFloat){
        initialPath = UIBezierPath(arcCenter: center, radius: 0, startAngle: 0, endAngle: CGFloat(2 * M_PI), clockwise: true).CGPath
        targetPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: CGFloat(M_PI * 2), clockwise: true).CGPath
        super.init()
        let targetX = center.x - radius
        let targetY = center.y - radius
        self.frame = CGRectMake(targetX,targetY,2*radius,2*radius)
        self.path = initialPath
        self.fillColor = fill.CGColor
        self.strokeColor = stroke.CGColor
        self.lineWidth = width
        self.backgroundColor = UIColor.randomColor().CGColor
    }
    
    var initialPath, targetPath: CGPath
    
    
    override init(){
        initialPath = UIBezierPath().CGPath
        targetPath = UIBezierPath().CGPath
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func startExpandAnimation() {
        let animation = CABasicAnimation(keyPath: "path")
        animation.fromValue = initialPath
        animation.toValue = targetPath
        animation.fillMode = kCAFillModeForwards
        animation.removedOnCompletion = false
        animation.duration = 4
        self.addAnimation(animation, forKey: "expand")
        self.path = targetPath
    }
}
