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
    case Unknown
}

class UCArenaView: UCStandardView {
    
    var pieceViews : [UCPieceView]?
    
    override init(father: UIView){
        super.init(father: father)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func performAnimationOnAllPiece(option: UCAnimationOption){
        guard pieceViews != nil && pieceViews?.count == 5 else { fatalError("Can't perform animation") }
        switch option{
        case .Expand:
            let centers = piecesCenter()
            let frames = piecesFrame()
            for i in 0..<pieceViews!.count{
                pieceViews![i].frame = CGRect(origin: centers[i], size: CGSizeMake(0, 0))
            }
            UIView.animateWithDuration(0.5, delay: 0, options: .CurveEaseIn, animations:
                {
                    self.pieceViews![0].frame = frames[0]
                    self.pieceViews![0].round()
                    self.pieceViews![0].alpha = 1
                }, completion: { (_) in
                    UIView.animateWithDuration(0.3, delay: 0, options: .CurveEaseIn, animations:
                        {
                            for i in [1,2,4]{
                                self.pieceViews![i].frame = frames[i]
                                self.pieceViews![i].round()
                                self.pieceViews![i].alpha = 1
                            }
                        }, completion: {(_) in
                            UIView.animateWithDuration(0.25, delay: 0, options: .CurveEaseIn, animations:
                                {
                                    self.pieceViews![3].frame = frames[3]
                                    self.pieceViews![3].round()
                                    self.pieceViews![3].alpha = 1
                                }, completion: nil
                            )
                        }
                    )
                }
            )
        default: break
        }
    }
    
    func piecesFrame() -> [CGRect]{
        let width = min(frame.width / 3, frame.height / 4)
        var result = [CGRect]()
        result.append(CGRect(x: 0, y: 0, width: width, height: width))
        result.append(CGRect(x: width * 2, y: 0, width: width, height: width))
        result.append(CGRect(x: width, y: width * 3 / 2, width: width, height: width))
        result.append(CGRect(x: width * 2, y: width * 3, width: width, height: width))
        result.append(CGRect(x: 0, y: width * 3, width: width, height: width))
        return result
    }
    
    func piecesCenter() -> [CGPoint]{
        let unit = min(frame.width / 6, frame.height / 8)
        var result = [CGPoint]()
        result.append(CGPoint(x: unit * 1, y: unit * 1))
        result.append(CGPoint(x: unit * 5, y: unit * 1))
        result.append(CGPoint(x: unit * 3, y: unit * 4))
        result.append(CGPoint(x: unit * 5, y: unit * 7))
        result.append(CGPoint(x: unit * 1, y: unit * 7))
        return result
    }
    
    func piecesWidth() -> CGFloat{
        return min(frame.width / 3, frame.height / 4)
    }
    
    func piecesRadius() -> CGFloat{
        return min(frame.width / 6, frame.height / 8)
    }
    
    func addPieces(){
        for piece in pieceViews!{
            addSubview(piece)
        }
    }
    
}
