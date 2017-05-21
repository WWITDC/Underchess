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
        backgroundColor = .clear
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(){
        super.init(frame: CGRect.zero)
        backgroundColor = .clear
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        guard let context = UIGraphicsGetCurrentContext() else { return }
        let points = ucCenters(in: frame)
        context.setLineJoin(.round)
        context.setLineWidth(10)
        context.setStrokeColor(UIColor.white.cgColor)
        context.move(to: CGPoint(x: points[0].x, y: points[0].y))
        context.addLine(to: CGPoint(x: points[4].x, y: points[4].y))
        context.addLine(to: CGPoint(x: points[1].x, y: points[1].y))
        context.addLine(to: CGPoint(x: points[0].x, y: points[0].y))
        context.addLine(to: CGPoint(x: points[3].x, y: points[3].y))
        context.addLine(to: CGPoint(x: points[1].x, y: points[1].y))
        context.strokePath()
    }

}
