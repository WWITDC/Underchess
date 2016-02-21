//
//  UCSplashViewController.swift
//  Underchess
//
//  Created by Apollonian on 16/2/13.
//  Copyright © 2016年 WWITDC. All rights reserved.
//

import UIKit

enum UCInterfaceOrientation{
    case Potrait, Landscape
}

class UCSplashViewController: UIViewController {
    
    private var currentPieceColor = UIColor.randomColor()
    
    var preExistingLayers = [CALayer]()
    var validDrawingArea = CGRect.zero
    
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
        let width = Int(view.frame.width)
        let height = Int(view.frame.height)
        if width < height{
            let validWidth = CGFloat(width - width % 3)
            let validHeight = CGFloat(height - height % 4)
            validDrawingArea = CGRect(origin: CGPointMake(view.frame.midX,view.frame.midY),size: CGSizeMake(validWidth, validHeight))
        } else {
            let validWidth = CGFloat(width - width % 4)
            let validHeight = CGFloat(height - height % 3)
            validDrawingArea = CGRect(origin: CGPointMake(view.frame.midX,view.frame.midY),size: CGSizeMake(validWidth, validHeight))
        }
    }
    
    
    func animation(mode: UCInterfaceOrientation){
        var pieces = Array(count: 5, repeatedValue: UCSplashPieceLayer())
        for index in 0..<pieces.count{
            switch index{
            case 0,1:
                pieces[index].color = .redColor()
            case 2:
                pieces[index].color = .whiteColor()
            case 3,4:
                pieces[index].color = .greenColor()
            default:
                break
            }
        }
        
        switch mode{
        case .Potrait:
            pieces[0].initialCenter = CGPointMake(
                validDrawingArea.width / 6,
                validDrawingArea.height / 8
            )
            pieces[1].initialCenter = CGPointMake(
                validDrawingArea.width * 5 / 6,
                validDrawingArea.height / 8
            )
            pieces[2].initialCenter = CGPointMake(
                validDrawingArea.width / 2,
                validDrawingArea.height / 2
            )
            pieces[3].initialCenter = CGPointMake(
                validDrawingArea.width / 6,
                validDrawingArea.height * 7 / 8
            )
            pieces[4].initialCenter = CGPointMake(
                validDrawingArea.width * 5 / 6,
                validDrawingArea.height * 7 / 8
            )        case .Landscape: break
        }
        
        for piece in pieces{
            piece.frame = view.frame
            piece.percentage = 12
            piece.finalCenter = piece.initialCenter
            view.layer.addSublayer(piece)
        }
        view.layer.setNeedsDisplay()
        pieces[0].animate()
        pieces[1].animate()
        pieces[2].animate()
        pieces[3].animate()
        pieces[4].animate()
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        // Calculate area that can be use to draw
        let width = Int(view.frame.width)
        let height = Int(view.frame.height)
        if width < height{
            let validWidth = CGFloat(width - width % 3)
            let validHeight = CGFloat(height - height % 4)
            validDrawingArea = CGRect(origin: CGPointMake(view.frame.midX,view.frame.midY),size: CGSizeMake(validWidth, validHeight))
            animation(.Potrait)
        } else {
            let validWidth = CGFloat(width - width % 4)
            let validHeight = CGFloat(height - height % 3)
            validDrawingArea = CGRect(origin: CGPointMake(view.frame.midX,view.frame.midY),size: CGSizeMake(validWidth, validHeight))
            animation(.Landscape)
        }
        // Clear All UCSplashPieceLayer
        view.layer.sublayers = preExistingLayers
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
