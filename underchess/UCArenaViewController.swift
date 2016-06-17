//
//  UCArenaViewController.swift
//  Underchess
//
//  Created by Apollonian on 16/2/13.
//  Copyright © 2016年 WWITDC. All rights reserved.
//

// MARK: DO NOT Remove Comments in This File

import UIKit

extension UCUserInputError: CustomStringConvertible{
    var description:String{
        get{
            switch self{
            case .controlUnownedPiece: return "Control unowned piece"
            case .noInvalidMove: return "No invalid move for the selcted piece"
            case .needUserSelection: return "Need to select the piece to move by the user"
            }
        }
    }
}

enum UCGamePhase{
    case ended, playing, notStarted
}

protocol UCArenaViewEventHandler {
    func endGame()
    var base: Any? {get}
}

var newUCArenaViewController = UCArenaViewController()

class UCArenaViewController: UIViewController, UCPieceProvider, UCPieceViewDelegate {
    var needAnimation = true

    /// May be Overrided Style with Key: preferedStyle
    var piecesWithStyle : [UCPieceView]?

    final func pieces() -> [UCPieceView]? {
        return piecesWithStyle
    }

    var arenaView: UCArenaView?

    // false -> player 0; true -> player 1
    private var situation : [Bool?] = [false,false,nil,true,true]
    internal var currentPlayer = false
    var gamingStatus = UCGamePhase.notStarted
    var movablePieces = [Int]()
    var eventHandler : UCArenaViewEventHandler?

    override func viewDidLoad() {
        super.viewDidLoad()
//        NC.addObserver(self, selector: #selector(updateUI), name: .UIDeviceOrientationDidChange, object: nil)
        view.backgroundColor = .ucBlue()
        arenaView = UCArenaView(father: view)
        arenaView?.provider = self
        arenaView?.pieceViewDelegate = self
        view.addSubview(arenaView!)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if needAnimation {
            arenaView?.performAnimationOnAllPiece(.expand, completion: nil)
        } else {
            arenaView?.performAnimationOnAllPiece(.none, completion: nil)
        }
        animateMovablePieces(forUser: !currentPlayer)
    }

    private func setMovablePieces(_ user: Bool){
        movablePieces.removeAll()
        let tagOfEmptySpot = situation.index {$0 == nil}!
        for i in 0...4{
            if situation[i] == !user{
                if !(i + tagOfEmptySpot == 7 || abs(i - tagOfEmptySpot) == 3){
                    movablePieces.append(i)
                }
            }
        }
    }

    func animateMovablePieces(forUser user: Bool){
        setMovablePieces(user)
        if !movablePieces.isEmpty{
            arenaView?.setMovablePieces(withTags: movablePieces)
        }
    }

    func touchUpInside(_ tagOfPieceToMove: Int) throws {
        if gamingStatus != .ended{
            if gamingStatus == .notStarted{
                gamingStatus = .playing
            }
            if situation[tagOfPieceToMove] == currentPlayer{
                var tagOfEmptySpot = situation.index(where: {$0 == nil})
                if tagOfPieceToMove + tagOfEmptySpot! == 7 || abs(tagOfPieceToMove - tagOfEmptySpot!) == 3 {
                    throw UCUserInputError.noInvalidMove
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
                        // MARK: Someone Won
                        arenaView?.setMovablePieces(withTags: [Int]())
                        gamingStatus = .ended
                        eventHandler?.endGame()
                    } else {
                        animateMovablePieces(forUser: currentPlayer)
                        currentPlayer = !currentPlayer
                    }
                }
            } else {
                throw UCUserInputError.controlUnownedPiece
            }

        }
    }

    func get(error: UCUserInputError) {}

    func startNew(){
        arenaView?.provider = nil
        arenaView?.pieceViewDelegate = nil
        piecesWithStyle = nil
        arenaView = nil
        if let window = eventHandler?.base as? UIWindow{
            window.rootViewController = newUCArenaViewController
        } else if let viewController = eventHandler?.base as? UIViewController{
            viewController.show(newUCArenaViewController, sender: nil)
        }
        self.eventHandler = nil
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        arenaView?.setupAgain(frame: CGRect(origin: .zero, size: size))
    }
}
