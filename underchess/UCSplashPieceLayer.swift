//
//  UCSplashPieceLayer.swift
//  Underchess
//
//  Created by Apollonian on 3/7/16.
//  Copyright © 2016 WWITDC. All rights reserved.
//

//import UIKit
//
//class UCSplashPieceLayer: CAShapeLayer {
//    init(fill: UIColor, stroke: UIColor, strokeWidth width: CGFloat, center: CGPoint, radius: CGFloat){
//        super.init()
//        let targetX = center.x - radius
//        let targetY = center.y - radius
//        self.frame = CGRectMake(targetX,targetY,2*radius,2*radius)
//        self.path = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: CGFloat(M_PI * 2), clockwise: true).CGPath
//        self.fillColor = fill.CGColor
//        self.strokeColor = stroke.CGColor
//        self.lineWidth = width
//    }
//    
//    override init(){
//        super.init()
//        let targetX = superlayer?.frame.minX ?? 0
//        let targetY = superlayer?.frame.minY ?? 0
//        let sides = min(superlayer?.frame.width ?? UIScreen.mainScreen().bounds.width,superlayer?.frame.height ?? UIScreen.mainScreen().bounds.height)
//        self.frame = CGRectMake(targetX,targetY,sides,sides)
//        let center = CGPointMake(superlayer?.frame.midX ?? UIScreen.mainScreen().bounds.midX, superlayer?.frame.midY ?? UIScreen.mainScreen().bounds.midY)
//        self.path = UIBezierPath(arcCenter: center, radius: sides / 2, startAngle: 0, endAngle: CGFloat(M_PI * 2), clockwise: true).CGPath
//        self.fillColor = UIColor.randomColor().CGColor
//        self.strokeColor = UIColor.randomColor().CGColor
//        self.lineWidth = 1
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        let targetX = superlayer?.frame.minX ?? 0
//        let targetY = superlayer?.frame.minY ?? 0
//        let sides = min(superlayer?.frame.width ?? UIScreen.mainScreen().bounds.width,superlayer?.frame.height ?? UIScreen.mainScreen().bounds.height)
//        self.frame = CGRectMake(targetX,targetY,sides,sides)
//        let center = CGPointMake(superlayer?.frame.midX ?? UIScreen.mainScreen().bounds.midX, superlayer?.frame.midY ?? UIScreen.mainScreen().bounds.midY)
//        self.path = UIBezierPath(arcCenter: center, radius: sides / 2, startAngle: 0, endAngle: CGFloat(M_PI * 2), clockwise: true).CGPath
//        self.fillColor = UIColor.randomColor().CGColor
//        self.strokeColor = UIColor.randomColor().CGColor
//        self.lineWidth = 1
//    }
//    
//}
