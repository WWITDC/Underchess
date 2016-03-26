//
//  UCArenaView.swift
//  Underchess
//
//  Created by Apollonian on 3/22/16.
//  Copyright © 2016 WWITDC. All rights reserved.
//

import UIKit

enum UCAnimationOption{
    case Expand
    case None
    case Unknown
}

protocol UCPieceProvider{
    func pieces() -> [UCPieceView]?
}

@IBDesignable class UCArenaView: UCStandardView {
    
    var currentSize : CGSize{
        get{
            return CGSizeMake(frame.width, frame.height)
        }
    }
    
    var lineViewFrame : CGRect{
        get{
            return CGRect(origin: CGPointZero, size: currentSize)
        }
    }
    
    var lineView : UCLineView? {
        didSet{
            setNeedsLayout()
            setNeedsDisplay()
        }
    }
    
    var pieceViews : [UCPieceView]?{
        didSet{
            setNeedsLayout()
            setNeedsDisplay()
        }
    }
    
    var provider: UCPieceProvider?
    
    override init(father: UIView){
        super.init(father: father)
        backgroundColor = .tianyiBlueColor()
        addLines()
        addPieces()
        setupAgain(frame: superview?.frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func performAnimationOnAllPiece(option: UCAnimationOption, completion todo: ((Bool) -> Void)?){
        if pieceViews != nil && pieceViews?.count == 5 { addPieces() }
        let pieceFrames = piecesFrame()
        let pieceCenters = ucCenter(frame)
        switch option{
        case .Expand:
            setupAgain(frame: superview?.frame)
            lineView?.frame = CGRect.zero
            for i in 0...4{
                pieceViews![i].frame = CGRect(origin: pieceCenters[i], size: CGSizeMake(0, 0))
            }
            UIView.animateWithDuration(0.25, animations: {
                self.lineView?.frame = self.lineViewFrame
                }, completion: { (_) in
                    UIView.animateWithDuration(0.5, delay: 0, options: .CurveEaseIn, animations:
                        {
                            self.pieceViews![0].frame = pieceFrames[0]
                            self.pieceViews![0].round()
                            self.pieceViews![0].alpha = 1
                        }, completion: { (_) in
                            UIView.animateWithDuration(0.3, delay: 0, options: .CurveEaseIn, animations:
                                {
                                    for i in [1,2,4]{
                                        self.pieceViews![i].frame = pieceFrames[i]
                                        self.pieceViews![i].round()
                                        self.pieceViews![i].alpha = 1
                                    }
                                }, completion: {(_) in
                                    UIView.animateWithDuration(0.1, delay: 0, options: .CurveEaseIn, animations:
                                        {
                                            self.pieceViews![3].frame = pieceFrames[3]
                                            self.pieceViews![3].round()
                                            self.pieceViews![3].alpha = 1
                                        }, completion: todo)}
                            )}
                    )
            })
            
        case .None:
            for i in 0...4{
                pieceViews![i].frame = pieceFrames[i]
                pieceViews![i].round()
                pieceViews![i].alpha = 1
            }
            lineView?.frame = self.frame
            todo
        default: break
        }
    }
    
    
    func piecesFrame() -> [CGRect]{
        var result = [CGRect]()
        if frame.height > frame.width{
            let width = min(frame.width / 3, frame.height / 4)
            result.append(CGRectMake(0, 0, width, width))
            result.append(CGRectMake(width * 2, 0, width, width))
            result.append(CGRectMake(width, width * 3 / 2, width, width))
            result.append(CGRectMake(width * 2, width * 3, width, width))
            result.append(CGRectMake(0, width * 3, width, width))
        } else {
            let width = min(frame.width / 4, frame.height / 3)
            result.append(CGRectMake(0, 0, width, width))
            result.append(CGRectMake(width * 3, 0, width, width))
            result.append(CGRectMake(width * 3 / 2, width, width, width))
            result.append(CGRectMake(width * 3, width * 2, width, width))
            result.append(CGRectMake(0, width * 2, width, width))
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
            pieceViews = piece
        } else if pieceViews == nil{
            pieceViews = [UCPieceView]()
            pieceViews?.append(UCPieceView(color: .ucPieceRedColor()))
            pieceViews?.append(UCPieceView(color: .ucPieceRedColor()))
            pieceViews!.append(UCPieceView(color: .whiteColor(), strokeColor: .blackColor(), strokeWdith: 1))
            pieceViews?.append(UCPieceView(color: .ucPieceGreenColor()))
            pieceViews?.append(UCPieceView(color: .ucPieceGreenColor()))
        }
        for piece in pieceViews!{
            addSubview(piece)
        }
    }
    
    func addLines(){
        if lineView != nil {
            lineView?.removeFromSuperview()
        }
        lineView = UCLineView(frame: lineViewFrame)
        insertSubview(lineView!, atIndex: 0)
    }
    
    override func didMoveToSuperview() {
        addLines()
        addPieces()
        setupAgain(frame: superview?.frame)
    }
    
    func setupAgain(frame temp: CGRect?) {
        let tmp = self.standardFrameInFrame(frame: temp)
        UIView.animateWithDuration(0.25, animations:
            {
                self.frame = tmp
            }, completion: {(_) in
                let pieceFrames = self.piecesFrame()
                UIView.animateWithDuration(0.5, delay: 0, options: .CurveEaseInOut, animations: {
                    for i in 0...4{
                        self.pieceViews![i].frame = pieceFrames[i]
                    }
                    self.lineView?.frame = self.lineViewFrame
                    }, completion: nil)
        })
    }
    
}
