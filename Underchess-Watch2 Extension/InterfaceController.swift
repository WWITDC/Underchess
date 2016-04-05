//
//  InterfaceController.swift
//  Underchess-Watch2 Extension
//
//  Created by Apollonian on 4/1/16.
//  Copyright © 2016 WWITDC. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    @IBOutlet var place0: WKInterfaceImage!
    @IBOutlet var place1: WKInterfaceImage!
    @IBOutlet var place2: WKInterfaceImage!
    @IBOutlet var place3: WKInterfaceImage!
    @IBOutlet var place4: WKInterfaceImage!
    @IBOutlet var line01: WKInterfaceImage!
    @IBOutlet var line04: WKInterfaceImage!
    @IBOutlet var line13: WKInterfaceImage!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        // Configure interface objects here.
        place0.setImage(UCPieceImageGenerator().roundPieceWithColor(.ucPieceRedColor()))
        place1.setImage(UCPieceImageGenerator().roundPieceWithColor(.ucPieceRedColor()))
        place1.setImage(UCPieceImageGenerator().roundPieceWithColor(.whiteColor()))
        place1.setImage(UCPieceImageGenerator().roundPieceWithColor(.ucPieceGreenColor()))
        place1.setImage(UCPieceImageGenerator().roundPieceWithColor(.ucPieceGreenColor()))
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
