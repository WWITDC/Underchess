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
    
    class func tianyiBlueColor() -> UIColor{
        return UIColor(red: 0.40, green: 0.80, blue: 1.00, alpha: 1.00)
    }
    
    class func ucPieceRedColor() -> UIColor{
        return UIColor(red: 0.92, green: 0.23, blue: 0.09, alpha: 1.00)
    }
    
    class func ucPieceGreenColor() -> UIColor{
        return UIColor(red: 0.04, green: 0.93, blue: 0.76, alpha: 1.00)
//        return UIColor(red: 0.00, green: 0.87, blue: 0.75, alpha: 1.00)
    }
    
    class func randomColor() -> UIColor{
        return UIColor(red: CGFloat(arc4random_uniform(255))/CGFloat(255) ,green: CGFloat(arc4random_uniform(255))/CGFloat(255) , blue: CGFloat(arc4random_uniform(255))/CGFloat(255) , alpha: CGFloat(arc4random_uniform(255))/CGFloat(255))
    }
    class func colorWithHex(code: String) -> UIColor{
        var array = [CGFloat]()
        for char in code.characters{
            switch char{
            case "0","1","2","3","4","5","6","7","8","9": array.append(CGFloat(Int(String(char))!))
            case "a","A": array.append(10)
            case "b","B": array.append(11)
            case "c","C": array.append(12)
            case "d","D": array.append(13)
            case "e","E": array.append(14)
            case "f","F": array.append(15)
            default: break
            }
        }
        var arguments = [CGFloat]()
        for i in 0...2{
            arguments.append(array[2*i]*16 + array[2*i+1])
        }
        return UIColor(red: arguments[0]/255, green: arguments[1]/255, blue: arguments[2]/255, alpha: 1)
    }
}

let NSUD = NSUserDefaults.standardUserDefaults()
let NC = NSNotificationCenter.defaultCenter()

func ucCenter(frame: CGRect) -> [CGPoint]{
    var result = [CGPoint]()
    if frame.height > frame.width{
        let unit = min(frame.width / 6, frame.height / 8)
        result.append(CGPointMake(unit * 1, unit * 1))
        result.append(CGPointMake(unit * 5, unit * 1))
        result.append(CGPointMake(unit * 3, unit * 4))
        result.append(CGPointMake(unit * 5, unit * 7))
        result.append(CGPointMake(unit * 1, unit * 7))
    } else {
        let unit = min(frame.width / 8, frame.height / 6)
        result.append(CGPointMake(unit * 1, unit * 1))
        result.append(CGPointMake(unit * 7, unit * 1))
        result.append(CGPointMake(unit * 4, unit * 3))
        result.append(CGPointMake(unit * 7, unit * 5))
        result.append(CGPointMake(unit * 1, unit * 5))
    }
    return result
}
