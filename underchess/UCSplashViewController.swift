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
        view.contentMode = .redraw
        view.backgroundColor = .tianyiBlue
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        arenaView = UCArenaView(father: view)
        arenaView?.performAnimationOnAllPiece(.expand, completion: { (_) in
            sleep(1)
            self.arenaView?.removeFromSuperview()
            let dialog = LLDialog()
            // Set title.
            dialog.title = "Tips"
            // Set content.
            dialog.message = "Player controlling red pieces will go first. If you shake your device before tapping any pieces, the other player will go first."

            // Set the buttons
            dialog.setPositiveButton(withTitle: "OK", target: self, action: #selector(UCSplashViewController.startGame))
            dialog.setNegativeButton()

            dialog.show()
        })
    }

    func startGame(){
        UIApplication.shared.keyWindow?.rootViewController = UCiOSArenaViewController()
    }

    override var prefersStatusBarHidden: Bool { return true }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask { return .portrait }

    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation { return .portrait }
    
}
