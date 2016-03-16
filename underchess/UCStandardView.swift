//
//  UCStandardView.swift
//  Underchess
//
//  Created by Apollonian on 3/7/16.
//  Copyright © 2016 WWITDC. All rights reserved.
//

import UIKit

// Creat a 3 * 4 (potrait) or 4 * 3 (landscape) view in the center of the superview
class UCStandardView: UIView {
    
    var orientation: UCInterfaceOrientation = .Potrait
    @IBInspectable var margin: CGFloat = 5

    override init(frame: CGRect){
        super.init(frame: frame)
        customSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customSetup()
    }
    
    func customSetup(){
        let father = superview
        frame = father?.frame ?? UIScreen.mainScreen().bounds
        var targetWidth, targetHeight: CGFloat
        if orientation == .Potrait{
            let arg1 = Int(frame.height - 2 * margin) / 4
            let arg2 = Int(frame.width - 2 * margin) / 3
            let scale = CGFloat(min(arg1,arg2))
            targetHeight = scale * 4
            targetWidth = scale * 3
            
        } else {
            let scale = CGFloat(min(Int(frame.height - 2 * margin) / 4,Int(frame.width - 2 * margin) / 3))
            targetHeight = scale * 3
            targetWidth = scale * 4
        }
        let targetX = frame.midX - targetWidth / 2
        let targetY = frame.midY - targetHeight / 2
        frame = CGRect(x: targetX, y: targetY, width: targetWidth, height: targetHeight)
        self.layer.frame = self.frame
        self.backgroundColor = .greenColor()
        setNeedsDisplay()
    }
    
}
