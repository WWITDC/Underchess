//
//  UCUtility.swift
//  Underchess
//
//  Created by Apollonian on 16/2/20.
//  Copyright © 2016年 WWITDC. All rights reserved.
//

import UIKit

extension UIColor{
    class func ucBlueColor() -> UIColor{
        return UIColor(red: 46.0 / 255.0, green: 117.0 / 255.0, blue: 146.0 / 255.0, alpha: 1.0)
    }
    class func randomColor() -> UIColor{
        return UIColor(red: CGFloat(arc4random_uniform(255))/CGFloat(255) ,green: CGFloat(arc4random_uniform(255))/CGFloat(255) , blue: CGFloat(arc4random_uniform(255))/CGFloat(255) , alpha: CGFloat(arc4random_uniform(255))/CGFloat(255))
    }
}

enum UCInterfaceOrientation{
    case Potrait, Landscape
    init(input: UIInterfaceOrientation){
        switch input{
        case .Portrait, .PortraitUpsideDown: self = .Potrait
        case .LandscapeLeft, .LandscapeRight: self = .Landscape
        case .Unknown: fatalError("Can not convert Unknown Interface Orientation")
        }
    }
}

// MARK: Flat Preloader
//protocol WDPausable{
//    func isPaused() -> Bool
//    func pause()
//    func resume()
//}
//
//extension CALayer: WDPausable{
//    func isPaused() -> Bool {
//        return self.speed == 0
//    }
//    func pause(){
//        if isPaused(){
//            return
//        }
//        let pausedTime = self.convertTime(CACurrentMediaTime(), fromLayer: nil)
//        self.speed = 0
//        self.timeOffset = pausedTime
//    }
//    func resume(){
//        if !isPaused(){
//            return
//        }
//        let pausedTime = self.timeOffset
//        self.speed = 1
//        self.timeOffset = 0
//        self.beginTime = 0
//        let timeSincePause = self.convertTime(CACurrentMediaTime(), fromLayer: nil) - pausedTime
//        self.beginTime = timeSincePause
//    }
//}
//
//class DotLayer: CAShapeLayer{
//    func draw(){
//        self.path = UIBezierPath(ovalInRect: self.bounds).CGPath
//    }
//}
//
//class FlatPreloader: UIView{
//    enum Style{
//        case Small, Medium, Big
//    }
//    
//    func startAnimating(){
//        
//    }
//    func stopAnimating(){
//        
//    }
//    func isAnimating() -> Bool{
//        return false
//    }
//    
//    init(style: FlatPreloader.Style){
//        var frame: CGRect
//        switch style{
//        case .Small: frame = CGRectMake(0, 0, 32, 32)
//        case .Medium: frame = CGRectMake(0, 0, 64, 64)
//        case .Big: frame = CGRectMake(0, 0, 128, 128)
//        }
//        super.init(frame: frame)
//    }
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
//
//class FlatPreloaderTypeA: FlatPreloader{
//    private enum QuadrantPosition: UInt{
//        case UpLeft = 0, UpRight, DownRight, DownLeft
//    }
//    private typealias Quadrant = (layer:DotLayer, position: QuadrantPosition)
//    private var quadrants : [Quadrant] = [(DotLayer(),.UpLeft),(DotLayer(),.UpRight),(DotLayer(),.DownRight),(DotLayer(),.DownLeft)]
//    private let insetLayer = CALayer()
//    private var animated = false
//    var dotColors:(upLeft:UIColor, upRight: UIColor,downRight:UIColor,downLeft:UIColor){
//        get{
//            return (UIColor(CGColor: self.quadrants[0].layer.fillColor!),UIColor(CGColor: self.quadrants[1].layer.fillColor!),UIColor(CGColor: self.quadrants[2].layer.fillColor!),UIColor(CGColor: self.quadrants[3].layer.fillColor!))
//        }
//        set{
//            self.quadrants[0].layer.fillColor = newValue.upLeft.CGColor
//            self.quadrants[1].layer.fillColor = newValue.upLeft.CGColor
//            self.quadrants[2].layer.fillColor = newValue.upLeft.CGColor
//            self.quadrants[3].layer.fillColor = newValue.upLeft.CGColor
//        }
//    }
//    var dotsDistance: CGFloat = 0
//    var reverseAnimation = false
//    var animationDuration: CFTimeInterval = 2.52
//    var padding: CGFloat = 0
//    var automaticCornerRadius = false
//    var hidesWhenStopped = true
//    private func addLayers(){
//        self.layer.addSublayer(self.insetLayer)
//        for quadrant in quadrants{
//            self.insetLayer.addSublayer(quadrant.layer)
//        }
//    }
//    init(frame: CGRect, dotDisiance: CGFloat = 0, dotColors: (UIColor,UIColor,UIColor,UIColor) = (.randomColor(),.randomColor(),.randomColor(),.randomColor()), animationDuration: CFTimeInterval = 2.52, reverseAnimation: Bool = false, padding: CGFloat = 0, hidesWhenStopped: Bool = true, automaticCornerRadius: Bool = false ){
//        super.init(frame: frame)
//        self.addLayers()
//        self.dotColors = dotColors
//        self.reverseAnimation = reverseAnimation
//        self.animationDuration = animationDuration
//        self.padding = padding
//        self.automaticCornerRadius = automaticCornerRadius
//        self.hidesWhenStopped = hidesWhenStopped
//    }
//    
//    override init(style: FlatPreloader.Style) {
//        var frame: CGRect
//        var padding: CGFloat
//        var distance: CGFloat
//        let colorA = UIColor(red: 237/255, green: 177/255, blue: 111/255, alpha: 1)
//        let colorB = UIColor(red: 80.0/255.0, green: 172.0/255.0, blue: 154.0/255.0, alpha: 1.0)
//        let colorC = UIColor(red: 210.0/255.0, green: 85.0/255.0, blue: 83.0/255.0, alpha: 1.0)
//        let colorD = UIColor(red: 54.0/255.0, green: 77.0/255.0, blue: 88.0/255.0, alpha: 1.0)
//        
//        switch style {
//        case .Small:
//            frame = CGRectMake(0,0,32,32)
//            padding = 3.0
//            distance = 1.0
//        case .Medium:
//            frame = CGRectMake(0, 0, 64, 64)
//            padding = 6.0
//            distance = 2.0
//        case .Big:
//            frame = CGRectMake(0, 0, 128, 128)
//            padding = 12.0
//            distance = 4.0
//        }
//        
//        super.init(style: style)
//        self.addLayers()
//        self.dotColors = (colorA, colorB, colorC, colorD)
//        self.dotsDistance = distance
//        self.padding = padding
//    }
//    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        self.insetLayer.frame = CGRectInset(self.layer.bounds, self.padding, self.padding)
//        let size = quadrantSize()
//        for quadrant in quadrants {
//            let origin = quadrantOrigin(quadrant.position)
//            quadrant.layer.frame = CGRect(origin: origin, size: size)
//            quadrant.layer.draw()
//        }
//        if self.automaticCornerRadius {
//            self.layer.cornerRadius = CGFloat(dotRadius()) + self.padding
//        }
//    }
//    
//    override func startAnimating() {
//        CATransaction.begin()
//        CATransaction.setDisableActions(true)
//        
//        for quadrant in self.quadrants {
//            if quadrant.layer.isPaused() {
//                quadrant.layer.resume()
//            } else {
//                quadrant.layer.addAnimation(quadrantAnimation(quadrant), forKey: "dotAnimation")
//            }
//        }
//        CATransaction.commit()
//    }
//    
//    override func stopAnimating() {
//        CATransaction.begin()
//        CATransaction.setDisableActions(true)
//        
//        for quadrant in self.quadrants {
//            quadrant.layer.pause()
//        }
//        
//        CATransaction.commit()
//        if self.hidesWhenStopped {
//            self.hidden = true
//        }
//    }
//    
//    override func isAnimating() -> Bool {
//        return self.animated
//    }
//    
//    /**
//     Returns a complete keyframe animation for one quadrant.
//     
//     
//     :param: quadrant The quadrant to animate.
//     
//     :returns: A quadrant animation.
//     */
//    private func quadrantAnimation(quadrant : Quadrant) -> CAKeyframeAnimation {
//        
//        var currentPoint = quadrantPosition(quadrant.position)
//        var currentQuadrant = quadrant.position
//        var functions : [CAMediaTimingFunction] = [] // For assigning a function to every keyframe animation
//        
//        var path = CGPathCreateMutable()
//        CGPathMoveToPoint(path, nil, currentPoint.x, currentPoint.y)
//        
//        // Add all corners (or quadrant positions)
//        for _ in 1...4 {
//            currentQuadrant = nextQuadrant(currentQuadrant)
//            currentPoint = quadrantPosition(currentQuadrant)
//            CGPathAddLineToPoint(path, nil, currentPoint.x, currentPoint.y)
//            functions.append(CAMediaTimingFunction(name: kCAMediaTimingFunctionDefault))
//        }
//        
//        var animation = CAKeyframeAnimation(keyPath: "position")
//        animation.path = path
//        animation.duration = self.animationDuration
//        animation.timingFunctions = functions
//        animation.repeatCount = Float(CGFloat.max)
//        
//        return animation
//    }
//    
//    /**
//     Returns the max dot radius for current combination of padding and dotsDistance. This number will be alway rounded to its floor value.
//     
//     :returns: The dots radius.
//     */
//    private func dotRadius() -> UInt{
//        let smallestSide = max(0, Float(min(self.insetLayer.bounds.size.height, self.insetLayer.bounds.size.width)) - Float(dotsDistance))
//        let triangleSide = Float(smallestSide) * sqrt(2.0) * 0.5
//        let semiperimeter = (triangleSide * 2.0 + smallestSide) * 0.5
//        if semiperimeter == 0 {
//            return 0
//        }
//        let triangleArea = (smallestSide * (smallestSide * 0.5)) * 0.5
//        let radius = triangleArea / semiperimeter
//        return UInt(floor(radius))
//    }
//    
//    /**
//     Returns the next quadrant position with current animation order (see reverse attribute).
//     
//     :param: quadrant The given quadrant.
//     
//     :returns: The next quadrant position.
//     */
//    private func nextQuadrant(quadrant: QuadrantPosition) -> QuadrantPosition {
//        if (reverseAnimation) {
//            return QuadrantPosition(rawValue: (quadrant.rawValue == 0 ? 3 : quadrant.rawValue - 1))!
//        } else {
//            return QuadrantPosition(rawValue: (quadrant.rawValue + 1) % 4)!
//        }
//        
//    }
//    
//    /**
//     Returns the max quadrant size for current combination of padding and dotsDistance.
//     
//     :returns: The quadrant size.
//     */
//    private func quadrantSize() -> CGSize {
//        let radius = CGFloat(dotRadius())
//        return CGSize(width: radius * 2.0, height: radius * 2.0)
//        
//    }
//    
//    /**
//     Returns the origin of the given quadrant from its current quadrantPosition (animation do not change quadrantPosition, so it's the starting origin).
//     
//     :param: quadrant The given quadrant.
//     
//     :returns: The quadrant origin.
//     */
//    private func quadrantOrigin(quadrant: QuadrantPosition) -> CGPoint{
//        let radius = CGFloat(dotRadius())
//        switch quadrant {
//        case .UpLeft:
//            return CGPoint(x: 0.0, y: 0.0)
//        case .UpRight:
//            return CGPoint(x: (self.insetLayer.bounds.width - radius * 2.0), y: 0)
//        case .DownRight:
//            return CGPoint(x: (self.insetLayer.bounds.width - radius * 2.0), y: (self.insetLayer.bounds.height - radius * 2.0))
//        case .DownLeft:
//            return CGPoint(x: 0, y: (self.insetLayer.bounds.height - radius * 2.0))
//        }
//        
//    }
//    
//    /**
//     Returns the position (anchor point 0.5, 0.5) of the given quadrant from its current quadrantPosition (animation do not change quadrantPosition, so it's the starting position).
//     
//     :param: quadrant The given quadrant.
//     
//     :returns: The quadrant position.
//     */
//    private func quadrantPosition(quadrant: QuadrantPosition) -> CGPoint {
//        let radius = CGFloat(dotRadius())
//        let origin = quadrantOrigin(quadrant)
//        
//        return CGPoint(x: origin.x + radius, y: origin.y + radius)
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}