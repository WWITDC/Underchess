//
//  UCArenaViewController.swift
//  Underchess
//
//  Created by Apollonian on 16/2/13.
//  Copyright © 2016年 WWITDC. All rights reserved.
//

// MARK: DO NOT Remove Comments in This File

import UIKit

class UCArenaViewController: UIViewController, UCPieceProvider {
    
    static let sharedInstance = UCArenaViewController()
    var needAnimation = true
    
    var piecesWithStyle : [UCPieceView]?
    
    func pieces() -> [UCPieceView]? {
        piecesWithStyle = [UCPieceView]()
        piecesWithStyle?.append(UCPieceView(color: .ucPieceRedColor()))
        piecesWithStyle?.append(UCPieceView(color: .ucPieceRedColor()))
        piecesWithStyle?.append(UCPieceView(color: .whiteColor(), strokeColor: .blackColor(), strokeWdith: 1))
        piecesWithStyle?.append(UCPieceView(color: .ucPieceGreenColor()))
        piecesWithStyle?.append(UCPieceView(color: .ucPieceGreenColor()))
        return piecesWithStyle
    }
    
//    var recordIdentifier: String?
    
    var arenaView: UCArenaView?
    
    private var situation = [0,0,2,1,1]
    private var currentPlayer = false
    private var didStart = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .ucBlueColor()
        NC.addObserver(self, selector: #selector(orientatoinDidChange), name: UIDeviceOrientationDidChangeNotification, object: nil)
        arenaView = UCArenaView(father: view)
        arenaView?.provider = self
        view.addSubview(arenaView!)
        /*
        if let identifier = recordIdentifier {
            let data = loadGameRecord(identifier)
            situation = data["situation"] as! [Int]
            currentPlayer = data["curPlayer"] as! Bool
            didStart = data["started"] as! Bool
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
    
    
    
    /*
    private func loadGameRecord(record: String) -> [String:AnyObject]{
        /*
         Game Record On Start Up (Does not support history):
         [
         "Situation":[0,0,2,1,1],
         "curPlayer":false,
         "started":false
         ]
         */
        let data = NSKeyedUnarchiver.unarchiveObjectWithData(NSUD.objectForKey(record) as! NSData)
        return data as! [String:AnyObject]
    }
    
    private func saveGameRecord(record: String){
        dispatch_async(dispatch_get_main_queue(), {
            let data = NSKeyedArchiver.archivedDataWithRootObject(["situation":self.situation, "curPlayer":self.currentPlayer, "started":self.didStart])
            NSUD.setObject(data, forKey: record)
            NSUD.synchronize()
        })
    }*/
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}
