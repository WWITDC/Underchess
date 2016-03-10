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
    
    init(margin: CGFloat, orientation: UCInterfaceOrientation, father: UIView){
        super.init(frame: CGRect.zero)
        frame = father.frame
        var targetWidth, targetHeight: CGFloat
        if orientation == .Potrait{
            let scale = CGFloat(min(Int(frame.height - 2 * margin) / 4,Int(frame.width - 2 * margin) / 3))
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
        self.backgroundColor = .randomColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
