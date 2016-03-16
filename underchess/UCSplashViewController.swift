//
//  UCSplashViewController.swift
//  Underchess
//
//  Created by Apollonian on 16/2/13.
//  Copyright © 2016年 WWITDC. All rights reserved.
//

import UIKit

class UCSplashViewController: UIViewController {
    
//    var piece = UCSplashPieceLayer()
//    
//    @IBOutlet var validatedDrawingArea: UCStandardView!
//    @IBOutlet weak var piece0: UCSplashPieceView!
//    
    override func viewDidLoad() {
        super.viewDidLoad()
        let validatedDrawingArea = UCStandardView(self.view.frame)
        validatedDrawingArea.customSetup()
        view.setNeedsDisplay()
//        
//        piece0.fillColor = .blueColor()
//        piece0.strokeColor = .blackColor()
    }
    
//    override func viewDidAppear(animated: Bool) {
//        super.viewDidAppear(animated)
//        validatedDrawingArea.customSetup()
//        piece0.fillColor = .blueColor()
//        piece0.strokeColor = .blackColor()
//        let validatedDrawingArea = UCStandardView(margin: 5, orientation: .Potrait, father: view)
//        let pieceViewFrame = CGRectMake(validatedDrawingArea.center.x - 20, validatedDrawingArea.center.y - 20, 40, 40)
//        let pieceView = UCSplashPieceView(frame: pieceViewFrame)
//        pieceView.strokeColor = .whiteColor()
//        pieceView.fillColor = .redColor()
//        pieceView.strokeWidth = 5
//        validatedDrawingArea.addSubview(pieceView)
//        let piece = UCSplashPieceLayer(fill: .redColor(), stroke: .blackColor(), strokeWidth: 5, center: validatedDrawingArea.center, radius: 20)
//        validatedDrawingArea.layer.addSublayer(piece)
//        view.addSubview(validatedDrawingArea)
//        print(validatedDrawingArea.layer.sublayers)
//        UIView.animateWithDuration(0.1, delay: 0, options: .CurveEaseIn, animations: {
//            piece.transform = CATransform3DMakeScale(0, 0, 1)
//            piece.opacity = 0
//            print(piece.superlayer)
//            }, completion: {(flag) in
//                UIView.animateWithDuration(2, delay: 0, options: .CurveEaseIn, animations: {
//                    print(flag)
//                    piece.opacity = 1
//                    piece.transform = CATransform3DMakeScale(1, 1, 1)
//                    }, completion: nil)
//        })
//    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return .Portrait
    }
    
}
