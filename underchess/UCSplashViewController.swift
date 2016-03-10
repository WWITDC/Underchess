//
//  UCSplashViewController.swift
//  Underchess
//
//  Created by Apollonian on 16/2/13.
//  Copyright © 2016年 WWITDC. All rights reserved.
//

import UIKit

class UCSplashViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(validatedDrawingArea)
        if view.frame.height > view.frame.width{
            prepare(forOrientatoin: .Potrait)
        } else {
            prepare(forOrientatoin: .Landscape)
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        piece = UCPieceLayer(fill: .randomColor(), stroke: .blackColor(), strokeWidth: 5, center: validatedDrawingArea.center, radius: 20)
        piece.hidden = false
        piece.startExpandAnimation()
    }
    
    var validatedDrawingArea = UCStandardView(margin: 5, orientation: .Potrait, father: UIView(frame: UIScreen.mainScreen().bounds)) {
        didSet{
            view.setNeedsDisplay()
            validatedDrawingArea.setNeedsDisplay()
            piece.setNeedsDisplay()
            print(validatedDrawingArea.frame)
        }
    }
    var piece = UCPieceLayer(){
        didSet{
            piece.setNeedsDisplay()
        }
    }

    func prepare(forOrientatoin orientation: UCInterfaceOrientation){
        validatedDrawingArea.removeFromSuperview()
        validatedDrawingArea = UCStandardView(margin: 5, orientation: orientation, father: view)
        self.view.addSubview(validatedDrawingArea)
        validatedDrawingArea.layer.addSublayer(piece)
        piece.hidden = true
    }

    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        if size.height > size.width{
            prepare(forOrientatoin: .Potrait)
        } else {
            prepare(forOrientatoin: .Landscape)
        }
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
