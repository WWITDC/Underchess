//
//  UCArenaViewController.swift
//  Underchess
//
//  Created by Apollonian on 16/2/13.
//  Copyright © 2016年 WWITDC. All rights reserved.
//

// MARK: DO NOT Remove Comments in This File

import UIKit

enum UserInputError:ErrorType{
    case ControlUnownedPiece
    case PlaceOnAnoherPiece
    case CrossNoncrossbleObject
}

enum UCGamePhase{
    case Ended, Playing, NotStarted
}

extension UserInputError: CustomStringConvertible{
    var description:String{
        get{
            switch self{
            case .CrossNoncrossbleObject: return "Cross noncrossble object"
            case .ControlUnownedPiece: return "Control unowned piece"
            case .PlaceOnAnoherPiece: return "Place on another piece"
            }
        }
    }
}

class UCArenaViewController: UIViewController, UCPieceProvider, UCPieceViewDelegate {
    
    static let sharedInstance = UCArenaViewController()
    var needAnimation = true
    
    var piecesWithStyle : [UCPieceView]?
    
    func pieces() -> [UCPieceView]? {
        // MARK: Maybe Override Style with Key: preferedStyle
        return piecesWithStyle
    }
    
    //    var recordIdentifier: String?
    
    var arenaView: UCArenaView?
    
    // false -> 0; true -> 1
    private var situation : [Bool?] = [false,false,nil,true,true]
    private var currentPlayer = false
    var didStartMoving = UITouchPhase.Ended
    var didStartGame = UCGamePhase.NotStarted
    var touchedPiece : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .ucBlueColor()
        NC.addObserver(self, selector: #selector(orientatoinDidChange), name: UIDeviceOrientationDidChangeNotification, object: nil)
        arenaView = UCArenaView(father: view)
        arenaView?.provider = self
        arenaView?.pieceViewDelegate = self
        view.addSubview(arenaView!)
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
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        arenaView?.setupAgain(frame: view.frame)
        if needAnimation {
            arenaView?.performAnimationOnAllPiece(.Expand, completion: nil)
        } else {
            arenaView?.performAnimationOnAllPiece(.None, completion: nil)
        }
        arenaView?.setupAgain(frame: view.frame)
    }
    
    func orientatoinDidChange(){
        arenaView?.setupAgain(frame: view.frame)
    }
    
    func touchUpInside(tag: Int) throws {
        switch didStartMoving {
        case .Began:
            if situation[tag] != nil {
                touchedPiece = nil
                didStartMoving = .Ended
                throw UserInputError.PlaceOnAnoherPiece
            } else if touchedPiece! + tag == 7 || abs(touchedPiece! - tag) == 3{
                touchedPiece = nil
                didStartMoving = .Ended
                throw UserInputError.CrossNoncrossbleObject
            } else {
                arenaView?.movePiece(pieceTag: touchedPiece!, toPlace: tag)
                swap(&situation[touchedPiece!], &situation[tag])
                touchedPiece = nil
                didStartMoving = .Ended
                var arg1 = 0, arg2 = 0
                for i in 0...4{
                    if situation[i] == !currentPlayer{
                        arg1 += i
                    } else if situation[i] != nil{
                        arg2 += i
                    }
                }
                if arg1 == 4 && (arg2 == 2 || arg2 == 3){
                    // TODO: Do something useful after one player won
                    let dialog = LLDialog()
                    
                    // Set title.
                    currentPlayer ? (dialog.title = "Player Green Won") : (dialog.title = "Player Red Won")
                    
                    // Set content.
                    dialog.content = "Congratulations. Do you want to play again? \n P.S. If you choose no, you can always shake your device and play again."
                    
                    // Set the buttons
                    dialog.setYesButton(self, title: "YES", action: "reInit")
                    dialog.setNoButton(self, title: "NO", action: nil)
                    
                    // Don't forget this line.
                    dialog.refreshUI()
                    
                    // At last, add it to your view.
                    self.view.addSubview(dialog)
                    didStartGame = .Ended
                }
                currentPlayer = !currentPlayer
            }
        case .Ended:
            if didStartGame == .NotStarted{
                didStartGame = .Playing
            }
            if situation[tag] == currentPlayer{
                touchedPiece = tag
                didStartMoving = .Began
            } else {
                throw UserInputError.ControlUnownedPiece
            }
        default:
            break
        }
    }
    
    func getError(error: ErrorType) {
        let dialog = LLDialog()
        
        // Set title.
        dialog.title = "Permission denied"
        
        // Set content.
        switch error{
        case UserInputError.ControlUnownedPiece:
            dialog.content = "You don't own that piece"
        case UserInputError.PlaceOnAnoherPiece:
            dialog.content = "You can't place your piece on another one"
        case UserInputError.CrossNoncrossbleObject:
            dialog.content = "That movement is not appropriate"
        default: dialog.content = "Some error occured"
        }
        
        // Set the buttons
        dialog.setYesButton(self, title: "OK", action: nil)
        dialog.setNoButton(self, title: "", action: nil)
        // Don't forget this line.
        dialog.refreshUI()
        
        // At last, add it to your view.
        view.addSubview(dialog)
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        super.motionEnded(motion, withEvent: event)
        if motion == UIEventSubtype.MotionShake{
            switch didStartGame {
            case .NotStarted:
                currentPlayer = !currentPlayer
            case .Ended:
                reInit()
            default:
                break
            }
        }
    }
    
    func reInit(){
        NC.removeObserver(self, name: UIDeviceOrientationDidChangeNotification, object: nil)
        presentViewController(UCArenaViewController(), animated: true, completion: nil)
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
