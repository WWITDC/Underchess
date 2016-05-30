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
    case NoInvalidMove
    case NeedUserSelection
}

enum UCGamePhase{
    case Ended, Playing, NotStarted
}

extension UserInputError: CustomStringConvertible{
    var description:String{
        get{
            switch self{
            case .ControlUnownedPiece: return "Control unowned piece"
            case .NoInvalidMove: return "No invalid move for the selcted piece"
            case .NeedUserSelection: return "Need to select the piece to move by the user"
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
    
    // false -> player 0; true -> player 1
    private var situation : [Bool?] = [false,false,nil,true,true]
    private var currentPlayer = false
    var gamingStatus = UCGamePhase.NotStarted
    var movablePieces = [Int]()

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
    
    func touchUpInside(tagOfPieceToMove: Int) throws {
        if gamingStatus == .NotStarted{
            gamingStatus = .Playing
        }
        if situation[tagOfPieceToMove] == currentPlayer{
            // MARK: Insert Here
            var tagOfEmptySpot = situation.indexOf({$0 == nil})
            if tagOfPieceToMove + tagOfEmptySpot! == 7 || abs(tagOfPieceToMove - tagOfEmptySpot!) == 3 {
                throw UserInputError.NoInvalidMove
            } else {
                arenaView?.movePiece(pieceTag: tagOfPieceToMove, toPlace: tagOfEmptySpot!)
                swap(&situation[tagOfPieceToMove], &situation[tagOfEmptySpot!])
                var arg1 = 0, arg2 = 0
                movablePieces.removeAll()
                for i in 0...4{
                    if situation[i] == !currentPlayer{
                        arg1 += i
                        movablePieces.append(i)
                    } else if situation[i] != nil{
                        arg2 += i
                    } else {
                        tagOfEmptySpot = i
                    }
                }
                if arg1 == 4 && (arg2 == 2 || arg2 == 3){
                    // TODO: Do something useful after one player won
                    let dialog = LLDialog()

                    // Set title.
                    currentPlayer ? (dialog.title = "Player Green Won") : (dialog.title = "Player Red Won")

                    // Set message.
                    dialog.message = "Congratulations. Do you want to play again? \n P.S. If you choose no, you can always shake your device and play again."

                    // Set the buttons
                    dialog.setPositiveButton(title: "Yes", target: self, action: #selector(reInit))
                    dialog.setNegativeButton(title: "No")

                    dialog.show()
                    gamingStatus = .Ended
                } else {
                    var tags = [Int]()
                    for i in 0..<movablePieces.count{
                        let tag = movablePieces[i]
                        if !(tag + tagOfEmptySpot! == 7 || abs(tag - tagOfEmptySpot!) == 3){
                            tags.append(tag)
                        }
                    }
                    arenaView?.setMovablePieces(withTags: tags)
                }
                currentPlayer = !currentPlayer
            }
        } else {
            throw UserInputError.ControlUnownedPiece
        }
    }
    
    func getError(error: ErrorType) {
        let dialog = LLDialog()
        
        // Set title.
        dialog.title = "Permission denied"
        
        // Set content.
        switch error{
        case UserInputError.ControlUnownedPiece:
            dialog.message = "You don't own that piece"
        case UserInputError.NoInvalidMove:
            dialog.message = "No invalid move for that piece"
        case UserInputError.NeedUserSelection:
            dialog.message = "Can't decide which piece to move. Please select by yourself."
        default: dialog.message = "An error has been occured"
        }
        
        // Set the buttons
        dialog.setPositiveButton(title: "OK")
        dialog.setNegativeButton()
        // Don't forget this line.
        dialog.show()
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        super.motionEnded(motion, withEvent: event)
        if motion == UIEventSubtype.MotionShake{
            switch gamingStatus {
            case .NotStarted:
                currentPlayer = !currentPlayer
            case .Ended:
                reInit()
            default:
                let dialog = LLDialog()
                dialog.title = "Restart the game?"
                dialog.message = "The game is not finished. Do you want to restart the game?"
                dialog.setPositiveButton(title: "YES", target: self, action: #selector(reInit))
                dialog.setNegativeButton(title: "No")
                dialog.show()
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
