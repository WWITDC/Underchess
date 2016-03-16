////
////  UCSplashPieceView.swift
////  Underchess
////
////  Created by Apollonian on 3/12/16.
////  Copyright © 2016 WWITDC. All rights reserved.
////
//
//import UIKit
//
//@IBDesignable class UCSplashPieceView: UIView {
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//    }
//        
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
//
//    @IBInspectable var strokeWidth: CGFloat = 1
//    @IBInspectable var fillColor = UIColor.randomColor(){
//        didSet{
//            setNeedsDisplay()
//        }
//    }
//    @IBInspectable var strokeColor = UIColor.randomColor(){
//        didSet{
//            setNeedsDisplay()
//        }
//    }
//    
////    init(fill: UIColor, stroke: UIColor, strokeWidth width: CGFloat, center: CGPoint, radius: CGFloat){
////        super.init()
////        let targetX = center.x - radius
////        let targetY = center.y - radius
////        self.frame = CGRectMake(targetX,targetY,2*radius,2*radius)
////        self.path = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: CGFloat(M_PI * 2), clockwise: true).CGPath
////        self.fillColor = fill.CGColor
////        self.strokeColor = stroke.CGColor
////        self.lineWidth = width
////    }
//
//    override func drawRect(rect: CGRect) {
//        let path = UIBezierPath(ovalInRect: self.frame)
////         let path = UIBezierPath(arcCenter: center, radius: frame.width / 2, startAngle: 0, endAngle: CGFloat(M_PI * 2), clockwise: true)
//        fillColor.setFill()
//        strokeColor.setStroke()
//        path.lineWidth = strokeWidth
//        path.fill()
//        path.stroke()
//    }
//
//}
