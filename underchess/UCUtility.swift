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