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

class UCArenaView: UCStandardView {
    
    var lines = KYCircularProgress()
    private var timer = NSTimer()
//    var flag = false
    
    //    var lineViews = [UCLineView]()
    
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
        //        let lineFrames = linesFrame()
        let pieceCenters = piecesCenter()
        //        let lineCenters = linesCenter()
        switch option{
        case .Expand:
            setupAgain(frame: superview?.frame)
            for i in 0...4{
                pieceViews![i].frame = CGRect(origin: pieceCenters[i], size: CGSizeMake(0, 0))
                //                lineViews[i].frame = CGRect(origin: lineCenters[i], size: CGSizeMake(0,0))
            }
            timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: #selector(updateLine), userInfo: nil, repeats: true)
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
            
            
            //                        UIView.animateWithDuration(0.1, delay: 0.1, options: .AllowAnimatedContent, animations: {
            //                            self.lineViews[0].frame = lineFrames[0]
            //                            self.lineViews[0].alpha = 1}, completion: { (_) in
            //                                UIView.animateWithDuration(0.1, delay: 0.1, options: .AllowAnimatedContent, animations: {
            //                                    self.lineViews[1].frame = lineFrames[1]
            //                                    self.lineViews[1].alpha = 1
            //                                    }
            //                                    , completion: { (_) in
            //                                        UIView.animateWithDuration(0.1, delay: 0.1, options: .AllowAnimatedContent, animations: {
            //                                            self.lineViews[2].frame = lineFrames[2]
            //                                            self.lineViews[2].alpha = 1
            //                                            }, completion: { (_) in
            //                                                UIView.animateWithDuration(0.1, delay: 0.1, options: .AllowAnimatedContent, animations: {
            //                                                    self.lineViews[3].frame = lineFrames[3]
            //                                                    self.lineViews[3].alpha = 1
            //                                                    }, completion: { (_) in
            //                                                        UIView.animateWithDuration(0.1, delay: 0.1, options: .AllowAnimatedContent, animations: {
            //                                                            self.lineViews[4].frame = lineFrames[4]
            //                                                            self.lineViews[4].alpha = 1
            //                                                            }, completion: { (_) in
            //
            //
            //                                                            }
            //                                                        )}
            //                                                )}
            //                                        )}
            //                                )}
        //                    )
        case .None:
            for i in 0...4{
                pieceViews![i].frame = pieceFrames[i]
                pieceViews![i].round()
                pieceViews![i].alpha = 1
                //                lineViews[i].frame = lineFrames[i]
                //                lineViews[i].alpha = 1
            }
            lines.path = pathForLines()
            lines.progress = 1
            todo
        default: break
        }
    }
    
    /*func animation(){
     
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
     
     }*/
    
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
    
    //    func linesFrame() -> [CGRect]{
    //        var result = [CGRect]()
    //        let data = piecesCenter()
    //        let side = piecesWidth()
    //        let offset = side / 2
    //        let x = data[0].x
    //        let y = data[0].y
    //        let totalWidth = frame.width - side
    //        let totalHeight = frame.height - side
    //        result.append(CGRectMake(x - offset, y, side, totalHeight))
    //        result.append(CGRectMake(x, y, totalWidth, totalHeight))
    //        result.append(CGRectMake(x, y, totalWidth, side))
    //        result.append(CGRectMake(x, y, totalWidth, totalHeight))
    //        result.append(CGRectMake(data[1].x - offset, data[1].y, side, totalHeight))
    //        return result
    //    }
    
    func piecesCenter() -> [CGPoint]{
        var result = [CGPoint]()
        if frame.height > frame.width{
            let unit = min(frame.width / 6, frame.height / 8)
            result.append(CGPointMake(unit * 1, unit * 1))
            result.append(CGPointMake(unit * 5, unit * 1))
            result.append(CGPointMake(unit * 3, unit * 4))
            result.append(CGPointMake(unit * 5, unit * 7))
            result.append(CGPointMake(unit * 1, unit * 7))
        } else {
            let unit = min(frame.width / 8, frame.height / 6)
            result.append(CGPointMake(unit * 1, unit * 1))
            result.append(CGPointMake(unit * 7, unit * 1))
            result.append(CGPointMake(unit * 4, unit * 3))
            result.append(CGPointMake(unit * 7, unit * 5))
            result.append(CGPointMake(unit * 1, unit * 5))
        }
        
        return result
    }
    
    func linesCenter() -> [CGPoint]{
        var result = [CGPoint]()
        let center = piecesCenter()
        result.append(center[0])
        result.append(center[4])
        result.append(center[1])
        result.append(center[0])
        result.append(center[3])
        result.append(center[1])
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
            pieceViews!.append(UCPieceView(color: .ucPieceRedColor(), strokeColor: .whiteColor(), strokeWdith: 1))
            pieceViews!.append(UCPieceView(color: .ucPieceRedColor(), strokeColor: .whiteColor(), strokeWdith: 1))
            pieceViews!.append(UCPieceView(color: .whiteColor(), strokeColor: .blackColor(), strokeWdith: 1))
            pieceViews!.append(UCPieceView(color: .ucPieceGreenColor(), strokeColor: .whiteColor(), strokeWdith: 1))
            pieceViews!.append(UCPieceView(color: .ucPieceGreenColor(), strokeColor: .whiteColor(), strokeWdith: 1))
        }
        for piece in pieceViews!{
            addSubview(piece)
        }
    }
    
    func addLines(){
        lines = KYCircularProgress(frame: self.frame)
        lines.colors = [.whiteColor()]
        let path = UIBezierPath()
        let data = linesCenter()
        path.moveToPoint(data[0])
        path.addLineToPoint(data[1])
        path.addLineToPoint(data[2])
        path.addLineToPoint(data[3])
        path.addLineToPoint(data[4])
        path.addLineToPoint(data[5])
        lines.path = path
        lines.progressChangedClosure { (progress, view) in
            if progress == 1{
                self.timer.invalidate()
//                self.flag = true
            }
        }
        addSubview(lines)
    }
    
    func pathForLines() -> UIBezierPath{
        let path = UIBezierPath()
        let data = linesCenter()
        path.moveToPoint(data[0])
        path.addLineToPoint(data[1])
        path.addLineToPoint(data[2])
        path.addLineToPoint(data[3])
        path.addLineToPoint(data[4])
        path.addLineToPoint(data[5])
        return path
    }
    
    override func didMoveToSuperview() {
        addLines()
        addPieces()
        setupAgain(frame: superview?.frame)
    }
    
    func setupAgain(frame temp: CGRect?) {
        UIView.animateWithDuration(0.25, animations: {
            self.frame = self.standardFrameInFrame(frame: temp)
        }) { (_) in
            let pieceFrames = self.piecesFrame()
            UIView.animateWithDuration(0.75, animations: {
                for i in 0...4{
                    self.pieceViews![i].frame = pieceFrames[i]
                }
                self.lines.frame = self.frame
                self.lines.path = nil
                self.lines.progress = 0
                self.lines.path = self.pathForLines()
                self.lines.progress = 100
            })
        }
    }
    
    func updateLine(){
        lines.progress += Double(1) / 5
    }
    
}
