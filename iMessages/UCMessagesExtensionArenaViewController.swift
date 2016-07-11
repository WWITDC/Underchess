//
//  UCMessagesExtensionArenaViewController.swift
//  Underchess
//
//  Created by Apollonian on 6/17/16.
//  Copyright © 2016 WWITDC. All rights reserved.
//

import UIKit
import Messages

class UCMessagesExtensionArenaViewController: UCArenaViewController, UCArenaViewControllerDelegate {

    var base: AnyObject?

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        // Do any additional setup after loading the view.
    }

    func endGame() {
        _ /*Message*/ = currentPlayer ?  ("Player Green Won") : ("Player Red Won")
    }
    
    func didTakeAMove() {
        (base as? MSMessagesAppViewController)?.requestPresentationStyle(.compact)
    }

    override func get(error: UCUserInputError) {

    }
}





