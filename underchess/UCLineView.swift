//
//  UCLineView.swift
//  Underchess
//
//  Created by Apollonian on 3/25/16.
//  Copyright © 2016 WWITDC. All rights reserved.
//

import UIKit

@IBDesignable class UCLineView: UIView{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clearColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(){
        super.init(frame: CGRect.zero)
        backgroundColor = .clearColor()
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        drawLine()
    }
    
    private func drawLine(){
        let points = ucCenter(frame)
        let context = UIGraphicsGetCurrentContext()
        /* Set the line join style for the line */
        CGContextSetLineJoin(context, .Round)
        /* Set the width for the line */
        CGContextSetLineWidth(context, 10)
        /* Set line Color */
        CGContextSetStrokeColorWithColor(context, UIColor.whiteColor().CGColor)
        /* Start the line at this point */
        CGContextMoveToPoint(context, points[0].x, points[0].y)
        /* And draw lines */
        CGContextAddLineToPoint(context, points[4].x, points[4].y)
        CGContextAddLineToPoint(context, points[1].x, points[1].y)
        CGContextAddLineToPoint(context, points[0].x, points[0].y)
        CGContextAddLineToPoint(context, points[3].x, points[3].y)
        CGContextAddLineToPoint(context, points[1].x, points[1].y)
        /* Use the context's current color to draw the line */
        CGContextStrokePath(context)
    }
    
}
