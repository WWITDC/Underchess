//
//  UCSplashViewController.swift
//  Underchess
//
//  Created by Apollonian on 16/2/13.
//  Copyright © 2016年 WWITDC. All rights reserved.
//

import UIKit

class UCSplashViewController: UIViewController {
    
    private var currentPieceColor = UIColor.randomColor()
    
    var preExistingLayers = [CALayer]()
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func colorForPiece() -> UIColor {
        print(currentPieceColor)
        return currentPieceColor
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        preExistingLayers = view.layer.sublayers!
        animation()
    }
    
    
    func animation(){
        var pieces = Array(count: 4, repeatedValue: UCSplashPieceLayer())
        for piece in pieces{
            piece.frame = view.frame
        }
        view.layer.addSublayer(pieces[0])
        pieces[0].color = .redColor()
        pieces[0].percentage = 20
        view.layer.setNeedsDisplay()
        pieces[0].animate()
    }
    
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        // Clear All UCSplashPieceLayer
        view.layer.sublayers = preExistingLayers
        animation()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
