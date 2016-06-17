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

protocol UCPieceProvider{
    func pieces() -> [UCPieceView]?
}

@IBDesignable class UCArenaView: UCStandardView {
    
    var pieceViewDelegate : UCPieceViewDelegate?{
        didSet{
            if let pieces = pieceViews{
                for piece in pieces{
                    piece.delegate = pieceViewDelegate
                }
            }
        }
    }
    
    var currentSize : CGSize{
        get{
            return CGSize(width: frame.width, height: frame.height)
        }
    }
    
    var lineViewFrame : CGRect{
        get{
            return CGRect(origin: CGPoint.zero, size: currentSize)
        }
    }
    
    var lineView : UCLineView? {
        didSet{
            setNeedsLayout()
            setNeedsDisplay()
        }
    }
    
    var pieceViews : [UCPieceView]?
    
    var provider: UCPieceProvider?
    
    override init(father: UIView){
        super.init(father: father)
        backgroundColor = .tianyiBlue()
        addLines()
        addPieces()
        setupAgain(frame: superview?.frame)
        father.addSubview(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func performAnimationOnAllPiece(_ option: UCAnimationOption, completion todo: ((Bool) -> ())?){
        if pieceViews != nil && pieceViews?.count == 5 { addPieces() }
        let pieceFrames = piecesFrame()
        let pieceCenters = ucCenter(frame)
        switch option{
        case .expand:
            setupAgain(frame: superview?.frame)
            lineView?.frame = CGRect.zero
            for i in 0...4{
                pieceViews![i].frame = CGRect(origin: pieceCenters[i], size: CGSize(width: 0, height: 0))
            }
            UIView.animate(withDuration: 0.25, animations: {
                self.lineView?.frame = self.lineViewFrame
                }, completion: { (_) in
                    UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations:
                        {
                            self.pieceViews![0].frame = pieceFrames[0]
                            self.pieceViews![0].round()
                            self.pieceViews![0].alpha = 1
                        }, completion: { (_) in
                            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations:
                                {
                                    for i in [1,2,4]{
                                        self.pieceViews![i].frame = pieceFrames[i]
                                        self.pieceViews![i].round()
                                        self.pieceViews![i].alpha = 1
                                    }
                                }, completion: {(_) in
                                    UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseIn, animations:
                                        {
                                            self.pieceViews![3].frame = pieceFrames[3]
                                            self.pieceViews![3].round()
                                            self.pieceViews![3].alpha = 1
                                        }, completion: todo)}
                            )}
                    )
            })
            
        case .none:
            for i in 0...4{
                pieceViews![i].frame = pieceFrames[i]
                pieceViews![i].round()
                pieceViews![i].alpha = 1
            }
            lineView?.frame = self.frame
            _ = todo
        default: break
        }
    }
    
    
    func piecesFrame() -> [CGRect]{
        var result = [CGRect]()
        if frame.height > frame.width{
            let width = min(frame.width / 3, frame.height / 4)
            result.append(CGRect(x: 0, y: 0, width: width, height: width))
            result.append(CGRect(x: width * 2, y: 0, width: width, height: width))
            result.append(CGRect(x: width, y: width * 3 / 2, width: width, height: width))
            result.append(CGRect(x: width * 2, y: width * 3, width: width, height: width))
            result.append(CGRect(x: 0, y: width * 3, width: width, height: width))
        } else {
            let width = min(frame.width / 4, frame.height / 3)
            result.append(CGRect(x: 0, y: 0, width: width, height: width))
            result.append(CGRect(x: width * 3, y: 0, width: width, height: width))
            result.append(CGRect(x: width * 3 / 2, y: width, width: width, height: width))
            result.append(CGRect(x: width * 3, y: width * 2, width: width, height: width))
            result.append(CGRect(x: 0, y: width * 2, width: width, height: width))
        }
        
        return result
    }
    
    func piecesWidth() -> CGFloat{
        return min(min(frame.width,frame.height) / 3, max(frame.width,frame.height) / 4)
    }
    
    func piecesRadius() -> CGFloat{
        return min(min(frame.width,frame.height) / 6, max(frame.width,frame.height) / 8)
    }
    
    func addPieces(){
        if let piece = provider?.pieces(){
            if piece.count == 5{
                pieceViews = piece
            } else {
                setupPieces()
            }
        } else if pieceViews == nil{
            setupPieces()
        }
        for i in 0...4{
            pieceViews![i].tag = i
            pieceViews![i].delegate = pieceViewDelegate
            addSubview(pieceViews![i])
        }
    }
    
    func setupPieces(){
        pieceViews = [UCPieceView]()
        pieceViews?.append(UCPieceView(color: .ucPieceRed()))
        pieceViews?.append(UCPieceView(color: .ucPieceRed()))
        pieceViews?.append(UCPieceView(color: .white(), strokeColor: .black(), strokeWdith: 1))
        pieceViews?.append(UCPieceView(color: .ucPieceGreen()))
        pieceViews?.append(UCPieceView(color: .ucPieceGreen()))
    }
    
    func addLines(){
        if lineView != nil {
            lineView?.removeFromSuperview()
        }
        lineView = UCLineView(frame: lineViewFrame)
        insertSubview(lineView!, at: 0)
    }
    
    override func didMoveToSuperview() {
        addLines()
        addPieces()
        setupAgain(frame: superview?.frame)
    }
    
    func setupAgain(frame temp: CGRect?) {
        let tmp = self.standardFrameInFrame(frame: temp)
        UIView.animate(withDuration: 0.25, animations:
            {
                self.frame = tmp
            }, completion: {(_) in
                let pieceFrames = self.piecesFrame()
                UIView.animate(withDuration: 0.5, delay: 0, options: UIViewAnimationOptions(), animations: {
                    for i in 0...4{
                        self.pieceViews![i].frame = pieceFrames[i]
                    }
                    self.lineView?.frame = self.lineViewFrame
                    }, completion: nil)
        })
    }
    
    func movePiece(pieceTag tag: Int, toPlace destination: Int){
        var arg1 = 0, arg2 = 0
        for i in 0...4{
            if pieceViews![i].tag == tag {
                arg1 = i
            } else if pieceViews![i].tag == destination{
                arg2 = i
            }
        }
        var temp = pieceViews
        swap(&temp![arg1],&temp![arg2])
        swap(&temp![arg1].tag, &temp![arg2].tag)
        pieceViews = temp
        let frames = piecesFrame()
        self.pieceViews![arg1].frame = frames[arg1]
        UIView.animate(withDuration: 0.5, animations: {
            self.pieceViews![arg2].frame = frames[arg2]
        }) { (_) in
            UIView.animate(withDuration: 0.25, animations: {
                self.pieceViews![arg1].alpha = 1
            })
        }
        
    }

    func setMovablePieces(withTags tags: [Int]){
        for piece in pieceViews!{
            piece.removeAllAnimations()
        }
        for tag in tags {
            pieceViews![tag].addRainbowSparkingAnimation()
        }
    }
    
}
