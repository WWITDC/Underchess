//
//  UCArenaView.swift
//  Underchess
//
//  Created by Apollonian on 3/22/16.
//  Copyright © 2016 WWITDC. All rights reserved.
//

import UIKit

enum UCAnimationOption{
    case expand
    case none
    case unknown
}

protocol UCPieceDataSource: class {
    var pieces: [UCPieceView]? { get set }
}

@IBDesignable class UCArenaView: UCStandardView {

    weak var pieceViewDelegate : UCPieceViewDelegate? {
        didSet {
            if let pieces = pieceViews {
                for piece in pieces {
                    piece.delegate = pieceViewDelegate
                }
            }
        }
    }

    var lineView = UCLineView() {
        didSet {
            setNeedsLayout()
            setNeedsDisplay()
        }
    }

    var pieceViews: [UCPieceView]!

    weak var dataSource: UCPieceDataSource?

    override init(father: UIView) {
        super.init(father: father)
        backgroundColor = .tianyiBlue
        addLines()
        addPieces()
        setupAgain(in: superview?.frame)
        father.addSubview(self)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func performAnimationOnAllPiece(_ option: UCAnimationOption, completion: ((Bool) -> Void)? = nil) {
        if pieceViews != nil && pieceViews?.count == 5 { addPieces() }
        let pieceFrames = piecesFrame()
        let pieceCenters = ucCenters(in: frame)
        switch option {
        case .expand:
            setupAgain(in: superview?.frame)
            lineView.frame = .zero
            for i in 0...4 {
                pieceViews[i].frame = CGRect(origin: pieceCenters[i], size: .zero)
            }
            UIView.animate(
                withDuration: 0.25,
                animations: { [bounds, weak self] in self?.lineView.frame = bounds },
                completion: { _ in
                    UIView.animate(
                        withDuration: 0.5, delay: 0, options: .curveEaseIn,
                        animations: { [weak self] in
                            self?.pieceViews[0].frame = pieceFrames[0]
                            self?.pieceViews[0].round()
                            self?.pieceViews[0].alpha = 1
                        },
                        completion: { _ in
                            UIView.animate(
                                withDuration: 0.3, delay: 0, options: .curveEaseIn,
                                animations: { [weak self] in
                                    for i in [1,2,4]{
                                        self?.pieceViews[i].frame = pieceFrames[i]
                                        self?.pieceViews[i].round()
                                        self?.pieceViews[i].alpha = 1
                                    }
                                },
                                completion: { _ in
                                    UIView.animate(
                                        withDuration: 0.1, delay: 0, options: .curveEaseIn,
                                        animations: { [weak self] in
                                            self?.pieceViews[3].frame = pieceFrames[3]
                                            self?.pieceViews[3].round()
                                            self?.pieceViews[3].alpha = 1
                                        },
                                        completion: completion)
                            })
                    })
            })

        case .none:
            for i in 0...4 {
                pieceViews[i].frame = pieceFrames[i]
                pieceViews[i].round()
                pieceViews[i].alpha = 1
            }
            lineView.frame = frame
            completion?(true)
        default: break
        }
    }


    func piecesFrame() -> [CGRect] {
        var result = [CGRect]()
        let width = piecesWidth
        if frame.height > frame.width {
            result.append(CGRect(x: 0, y: 0, width: width, height: width))
            result.append(CGRect(x: width * 2, y: 0, width: width, height: width))
            result.append(CGRect(x: width, y: width * 3 / 2, width: width, height: width))
            result.append(CGRect(x: width * 2, y: width * 3, width: width, height: width))
            result.append(CGRect(x: 0, y: width * 3, width: width, height: width))
        } else {
            result.append(CGRect(x: 0, y: 0, width: width, height: width))
            result.append(CGRect(x: width * 3, y: 0, width: width, height: width))
            result.append(CGRect(x: width * 3 / 2, y: width, width: width, height: width))
            result.append(CGRect(x: width * 3, y: width * 2, width: width, height: width))
            result.append(CGRect(x: 0, y: width * 2, width: width, height: width))
        }
        return result
    }

    var piecesWidth: CGFloat {
        return min(min(frame.width,frame.height) / 3, max(frame.width,frame.height) / 4)
    }

    var piecesRadius: CGFloat {
        return piecesWidth / 2
    }

    func addPieces() {
        if let piece = dataSource?.pieces, piece.count == 5 {
            pieceViews = piece
        } else {
            setupPieces()
        }
        for i in 0...4 {
            pieceViews[i].tag = i
            pieceViews[i].delegate = pieceViewDelegate
            addSubview(pieceViews[i])
        }
    }

    func setupPieces() {
        pieceViews = [UCPieceView]()
        pieceViews.append(UCPieceView(color: .ucPieceRed))
        pieceViews.append(UCPieceView(color: .ucPieceRed))
        pieceViews.append(UCPieceView(color: .white, strokeColor: .black, strokeWidth: 1))
        pieceViews.append(UCPieceView(color: .ucPieceGreen))
        pieceViews.append(UCPieceView(color: .ucPieceGreen))
    }

    final func addLines() {
        lineView.removeFromSuperview()
        lineView = UCLineView(frame: bounds)
        insertSubview(lineView, at: 0)
    }

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        addLines()
        addPieces()
        setupAgain(in: superview?.frame)
    }

    func setupAgain(in superFrame: CGRect?) {
        UIView.animate(
            withDuration: 0.25,
            animations: { [newFrame = standardFrame(inRect: superFrame), weak self] in self?.frame = newFrame },
            completion: { _ in
                UIView.animate(withDuration: 0.5) { [weak self] in
                    guard let weakSelf = self else { return }
                    let pieceFrames = weakSelf.piecesFrame()
                    for i in 0...4 {
                        weakSelf.pieceViews[i].frame = pieceFrames[i]
                    }
                    weakSelf.lineView.frame = weakSelf.bounds
                }
        }
        )
    }

    final func movePiece(from selectedTag: Int, to destinationTag: Int) {
        var selectedIndex = 0, destinationIndex = 0
        for i in 0...4 {
            if pieceViews[i].tag == selectedTag {
                selectedIndex = i
            } else if pieceViews[i].tag == destinationTag {
                destinationIndex = i
            }
        }
        var pieces = pieceViews!
        swap(&pieces[selectedIndex],&pieces[destinationIndex])
        swap(&pieces[selectedIndex].tag, &pieces[destinationTag].tag)
        pieceViews = pieces
        let frames = piecesFrame()
        pieceViews[selectedIndex].frame = frames[selectedIndex]

        UIView.animate(
            withDuration: 0.5,
            animations: { [weak self] in self?.pieceViews[destinationTag].frame = frames[destinationTag] },
            completion: { _ in
                UIView.animate(withDuration: 0.25) { [weak self] in self?.pieceViews[selectedIndex].alpha = 1 }
        })
    }

    func setMovablePieces(withTags tags: [Int]) {
        for piece in pieceViews {
            piece.removeAllAnimations()
        }
        for tag in tags {
            pieceViews[tag].addRainbowSparkingAnimation()
        }
    }
    
}
