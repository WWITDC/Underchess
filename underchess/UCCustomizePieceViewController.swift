//
//  UCCustomizePieceViewController.swift
//  Underchess
//
//  Created by Apollonian on 3/22/16.
//  Copyright © 2016 WWITDC. All rights reserved.
//

import UIKit

class UCCustomizePieceViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // FIXME: Add Feature Later
        UIApplication.shared().keyWindow?.rootViewController = UCArenaViewController()
    }

}
