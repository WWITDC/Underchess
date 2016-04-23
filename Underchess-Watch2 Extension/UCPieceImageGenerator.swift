//
//  UCPieceImageGenerator.swift
//  Underchess
//
//  Created by Apollonian on 4/1/16.
//  Copyright © 2016 WWITDC. All rights reserved.
//

import WatchKit
import UIKit
import Foundation
import CoreGraphics

class UCPieceImageGenerator {
    func roundPieceWithColor(color: UIColor) -> UIImage{
        let size = CGSizeMake(10,10)
        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()
        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextAddEllipseInRect(context, CGRect(origin: CGPoint.zero, size: size))
        CGContextFillEllipseInRect(context, CGRect(origin: CGPoint.zero, size: size))
        let output = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return output
    }
}
