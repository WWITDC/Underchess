//
//  UCUtility.swift
//  Underchess
//
//  Created by Apollonian on 16/2/20.
//  Copyright © 2016年 WWITDC. All rights reserved.
//

import UIKit

enum UCDirection{
    case up
    case down
    case left
    case right
}

extension UIColor {
    static let ucBlue = #colorLiteral(red: 0.18, green: 0.46, blue: 0.57, alpha: 1)
    static let tianyiBlue = #colorLiteral(red: 0.4, green: 0.8, blue: 1, alpha: 1)
    static let ucPieceRed = #colorLiteral(red: 0.92, green: 0.23, blue: 0.09, alpha: 1)
    static let ucPieceGreen = #colorLiteral(red: 0.04, green: 0.93, blue: 0.76, alpha: 1)

    class func random() -> UIColor {
        let rand = { CGFloat(arc4random_uniform(255)) / CGFloat(255) }
        return UIColor(red: rand(), green: rand() , blue: rand(), alpha: rand())
    }

    convenience init?(hex code: String) {
        guard let hex = Int(code, radix: 16) else { return nil }
        self.init(red: CGFloat(hex & 0xFF0000), green: CGFloat(hex & 0xFF00), blue: CGFloat(hex & 0xFF), alpha: 1)
    }
}

func ucCenters(in frame: CGRect) -> [CGPoint] {
    var result = [CGPoint]()
    if frame.height > frame.width {
        let unit = min(frame.width / 6, frame.height / 8)
        result.append(CGPoint(x: unit * 1, y: unit * 1))
        result.append(CGPoint(x: unit * 5, y: unit * 1))
        result.append(CGPoint(x: unit * 3, y: unit * 4))
        result.append(CGPoint(x: unit * 5, y: unit * 7))
        result.append(CGPoint(x: unit * 1, y: unit * 7))
    } else {
        let unit = min(frame.width / 8, frame.height / 6)
        result.append(CGPoint(x: unit * 1, y: unit * 1))
        result.append(CGPoint(x: unit * 7, y: unit * 1))
        result.append(CGPoint(x: unit * 4, y: unit * 3))
        result.append(CGPoint(x: unit * 7, y: unit * 5))
        result.append(CGPoint(x: unit * 1, y: unit * 5))
    }
    return result
}
