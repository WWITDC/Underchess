//
//  UCSplashViewController.swift
//  Underchess
//
//  Created by Apollonian on 16/2/13.
//  Copyright © 2016年 WWITDC. All rights reserved.
//

import UIKit

class UCSplashViewController: UIViewController {
    
    var arenaView: UCArenaView?
 
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .tianyiBlueColor()
        arenaView = UCArenaView(father: view)
        view.addSubview(arenaView!)
        var pieces = [UCPieceView]()
        pieces.append(UCPieceView(color: .redColor(), strokeColor: .whiteColor(), strokeWdith: 1))
        pieces.append(UCPieceView(color: .redColor(), strokeColor: .whiteColor(), strokeWdith: 1))
        pieces.append(UCPieceView(color: .whiteColor(), strokeColor: .blackColor(), strokeWdith: 1))
        pieces.append(UCPieceView(color: .greenColor(), strokeColor: .whiteColor(), strokeWdith: 1))
        pieces.append(UCPieceView(color: .greenColor(), strokeColor: .whiteColor(), strokeWdith: 1))
        for i in 0..<pieces.count {
            pieces[i].tag = i
        }
        arenaView!.pieceViews = pieces
        arenaView?.addPieces()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        arenaView?.performAnimationOnAllPiece(.Expand)
    }

    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return .Portrait
    }
    
}
