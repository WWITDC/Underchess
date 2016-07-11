//
//  UCiOSArenaViewController.swift
//  Underchess
//
//  Created by Apollonian on 6/16/16.
//  Copyright © 2016 WWITDC. All rights reserved.
//

import UIKit

class UCiOSArenaViewController: UCArenaViewController, UCArenaViewControllerDelegate {

    //    var recordIdentifier: String?

    var base: AnyObject?

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        base = UIApplication.shared().keyWindow
        /*
         if let identifier = recordIdentifier {
         let data = loadGameRecord(identifier)
         situation = data["situation"] as! [Int]
         currentPlayer = data["currentPlayer"] as! Bool
         didStartMoving = data["started"] as! Bool
         didStartGame = data["didStartGame"] as UITouchPhase
         // Consider later
         } else {*/
        /*}*/
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

    //    private func timeMachine(){
    //        arenaView?.removeFromSuperview()
    //        arenaView = nil
    //        situation = [false,false,nil,true,true]
    //        currentPlayer = false
    //        didStartMoving = UITouchPhase.Ended
    //        didStartGame = UCGamePhase.NotStarted
    //        touchedPiece = nil
    //    }
    //
    /*
     private func loadGameRecord(record: String) -> [String:AnyObject]{
     /*
     Game Record On Start Up (Does not support history):
     [
     "situation":[0,0,2,1,1],
     "currentPlayer":false,
     "didStartMoving":.Ended,
     "didStartGame": false
     ]
     */
     let data = NSKeyedUnarchiver.unarchiveObjectWithData(NSUD.objectForKey(record) as! NSData)
     return data as! [String:AnyObject]
     }

     private func saveGameRecord(record: String){
     dispatch_async(dispatch_get_main_queue(), {
     let data = NSKeyedArchiver.archivedDataWithRootObject(["situation":self.situation, "currentPlayer":self.currentPlayer, "didStartMoving":self.didStartMoving,"didStartGame":self.didStartGame])
     NSUD.setObject(data, forKey: record)
     NSUD.synchronize()
     })
     }*/
}
