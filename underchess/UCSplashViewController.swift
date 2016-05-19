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
        view.contentMode = .Redraw
        view.backgroundColor = .tianyiBlueColor()
        arenaView = UCArenaView(father: view)
        view.addSubview(arenaView!)        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        arenaView?.setupAgain(frame: view.frame)
        arenaView?.performAnimationOnAllPiece(.Expand, completion: { (_) in
            sleep(1)
//            self.presentViewController(UCMainViewController(), animated: true, completion: nil)
            UCArenaViewController.sharedInstance.needAnimation = false
            self.arenaView?.removeFromSuperview()
            
            let dialog = LLDialog()
            
            // Set title.
            dialog.title = "Tips"
            
            // Set content.
            dialog.content = "Player controlling red pieces will go first. If you shake your device before tapping any pieces, the other player will go first."
            
            // Set the buttons
            dialog.setYesButton(self, title: "OK", action: "next")
            dialog.setNoButton(self, title: "", action: nil)
            
            // Don't forget this line.
            dialog.refreshUI()
            
            // At last, add it to your view.
            self.view.addSubview(dialog)
        })
    }
    
    func next(){
        presentViewController(UCArenaViewController.sharedInstance, animated: true, completion: nil)
    }
    
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return .Portrait
    }
    
    override func preferredInterfaceOrientationForPresentation() -> UIInterfaceOrientation {
        return .Portrait
    }
    
}
