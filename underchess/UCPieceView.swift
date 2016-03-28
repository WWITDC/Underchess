//
//  UCPieceView.swift
//  Underchess
//
//  Created by Apollonian on 3/22/16.
//  Copyright © 2016 WWITDC. All rights reserved.
//

import UIKit

protocol UCPieceViewDelegate{
    func getError(error: ErrorType)
    func touchUpInside(tag: Int) throws
//    func touchesMovedToDirection()
    
}

enum UCDirection{
    case Up
    case Down
    case UpLeft
    case DownLeft
    case UpRight
    case DownRight
    case Left
    case right
}

@IBDesignable class UCPieceView: UIView {
    
    var currentTouchMovingDirection: UCDirection?
    var delegate: UCPieceViewDelegate?
    
    init(color: UIColor){
        super.init(frame: CGRect.zero)
        backgroundColor = color
        alpha = 0
        layer.borderWidth = 5
        layer.borderColor = UIColor.whiteColor().CGColor
    }
    
    init(color: UIColor, strokeColor: UIColor, strokeWdith: CGFloat){
        super.init(frame: CGRect.zero)
        backgroundColor = color
        alpha = 0
        layer.borderWidth = strokeWdith
        layer.borderColor = strokeColor.CGColor
    }
    
    init(frame: CGRect, cornerRadius radius: CGFloat, color: UIColor, picture: UIImage?, animatable: Bool?){
        super.init(frame: frame)
        // MARK: New Feature: Customized Background
        /*
         if let image = picture{
         if let needAnimation = animatable{
         
         } else {
         
         }
         }
         */
        layer.cornerRadius = radius
        backgroundColor = color
        alpha = 0
    }
    
    func round(){
        layer.cornerRadius = min(frame.width, frame.height) / 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        super.touchesMoved(touches, withEvent: event)
//        
//    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesEnded(touches, withEvent: event)
        if currentTouchMovingDirection == nil{
            if let handler = delegate{
                do{
                    try handler.touchUpInside(tag)
                } catch let error {
                    handler.getError(error)
                }
            }
        }
    }
}
