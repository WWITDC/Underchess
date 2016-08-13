//
//  UCiOSArenaViewController.swift
//  Underchess
//
//  Created by Apollonian on 6/16/16.
//  Copyright © 2016 WWITDC. All rights reserved.
//

import UIKit

class UCiOSArenaViewController: UCArenaViewController, UCArenaViewControllerDelegate {

    var base: AnyObject?

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        base = UIApplication.shared().keyWindow
    }

    func endGame() {
        let dialog = LLDialog()
        dialog.title = currentPlayer ? ("Player Green Won") : ("Player Red Won")
        dialog.message = "Congratulations. Do you want to play again? \n P.S. If you choose `No`, you can always shake your device and play again."
        dialog.setPositiveButton(title: "Yes", target: self, action: #selector(startNew))
        dialog.setNegativeButton(title: "No")
        dialog.show()
        newUCArenaViewController = UCiOSArenaViewController()
    }

    override func get(error: UCUserInputError) {
        super.get(error: error)
        let dialog = LLDialog()
        dialog.title = "Permission denied"
        dialog.message = error.description
        dialog.setPositiveButton(title: "OK")
        dialog.setNegativeButton()
        dialog.show()
    }

    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        super.motionEnded(motion, with: event)
        if motion == UIEventSubtype.motionShake{
            switch gamingStatus {
            case .notStarted:
                currentPlayer = !currentPlayer
            case .ended:
                startNew()
            case .playing:
                let dialog = LLDialog()
                dialog.title = "Restart the game?"
                dialog.message = "The game is not finished. Do you want to restart the game?"
                dialog.setPositiveButton(title: "YES", target: self, action: #selector(startNew))
                dialog.setNegativeButton(title: "No")
                dialog.show()
            }
        }
    }
}
