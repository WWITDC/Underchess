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
            case .noValidMove: return "No invalid move for the selcted piece"
            case .needUserSelection: return "Need to select the piece to move by the player"
            }
        }
    }
}

enum UCGamePhase{
    case ended, playing, notStarted
}

@objc protocol UCArenaViewControllerDelegate {
    @objc optional func endGame()
    @objc var base: AnyObject? {get}
    @objc optional func didTakeAMove()
}

var newUCArenaViewController = UCArenaViewController()

class UCArenaViewController: UIViewController, UCPieceDataSource, UCPieceViewDelegate {
    var needAnimation = true

    /// May be Overrided Style with Key: preferedStyle
    var pieces : [UCPieceView]?

    var arenaView: UCArenaView?

    /// false -> player 0(Red); true -> player 1(Green)
    public private(set) var boardStatus: [Bool?] = [false,false,nil,true,true]

    final var emptySpotIndex: Int! {
        return boardStatus.index { $0 == nil }
    }

    var currentPlayer = false {
        willSet {
            animateMovablePieces(for: currentPlayer)
        }
    }
    var theOtherPlayer: Bool {
        return !currentPlayer
    }
    var gamingStatus = UCGamePhase.notStarted
    var movablePieces = [Int]()
    weak var delegate: UCArenaViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .ucBlue
        arenaView = UCArenaView(father: view)
        arenaView?.dataSource = self
        arenaView?.pieceViewDelegate = self
        view.addSubview(arenaView!)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        arenaView?.performAnimationOnAllPiece((needAnimation) ? .expand : .none)
        animateMovablePieces(for: theOtherPlayer)
    }

    private func setMovablePieces(for player: Bool){
        movablePieces.removeAll()
        for i in 0...4 {
            if boardStatus[i] == !player && hasValidMove(forPiece: i) {
                movablePieces.append(i)
            }
        }
    }

    final func animateMovablePieces(for player: Bool){
        setMovablePieces(for: player)
        if !movablePieces.isEmpty {
            arenaView?.setMovablePieces(withTags: movablePieces)
        }
    }

    final func hasValidMove(forPiece selectedIndex: Int) -> Bool{
        return !(selectedIndex + emptySpotIndex == 7 || abs(selectedIndex - emptySpotIndex) == 3)
    }

    final func move(from startIndex: Int, to endIndex: Int){
        arenaView?.movePiece(from: startIndex, to: endIndex)
        swap(&boardStatus[startIndex], &boardStatus[endIndex])
    }

    final func hasValidMove(forPlayer player: Bool) -> Bool{
        var thisPlayerIndexes = 0, anotherPlayerIndexes = 0
        movablePieces.removeAll()
        for i in 0...4 {
            if boardStatus[i] == player {
                thisPlayerIndexes += i
            } else if boardStatus[i] != nil {
                anotherPlayerIndexes += i
            }
        }
        return !(thisPlayerIndexes == 4 && (anotherPlayerIndexes == 2 || anotherPlayerIndexes == 3))
    }

    final func touchUpInside(pieceWithIndex touchedIndex: Int) throws {
        guard gamingStatus != .ended else { return }
        if gamingStatus == .notStarted {
            gamingStatus = .playing
        }
        if boardStatus[touchedIndex] == currentPlayer {
            if hasValidMove(forPiece: touchedIndex) {
                move(from: touchedIndex, to: emptySpotIndex)
                delegate?.didTakeAMove?()
                if hasValidMove(forPlayer: theOtherPlayer) {
                    currentPlayer = theOtherPlayer
                } else {
                    arenaView?.setMovablePieces(withTags: [])
                    gamingStatus = .ended
                    if let delegate = delegate, let endGame = delegate.endGame {
                        endGame()
                    } else {
                        startNew()
                    }
                }
            } else {
                throw UCUserInputError.noValidMove
            }
        } else {
            throw UCUserInputError.controlUnownedPiece
        }
    }

    func get(error: UCUserInputError) {}

    final func startNew() {
        arenaView?.dataSource = nil
        arenaView?.pieceViewDelegate = nil
        pieces = nil
        arenaView = nil
        if let window = delegate?.base as? UIWindow {
            window.rootViewController = newUCArenaViewController
        } else if let viewController = delegate?.base as? UIViewController{
            viewController.show(newUCArenaViewController, sender: nil)
        }
        self.delegate = nil
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        arenaView?.setupAgain(in: CGRect(origin: .zero, size: size))
    }
}
