//
//  UCStickerBrowserViewController.swift
//  Underchess
//
//  Created by Apollonian on 6/17/16.
//  Copyright © 2016 WWITDC. All rights reserved.
//

import UIKit
import Messages

class UCStickerBrowserViewController: MSStickerBrowserViewController {

    var stickers = [MSSticker]()

    func changeBrowserView(backgroundColor: UIColor){
        stickerBrowserView.backgroundColor = backgroundColor
    }

    func loadStickers(){
        createSticker(asset: "Logo", localizedDescription: "Logo")
    }

    func createSticker(asset: String, localizedDescription: String){
        if let stickerPath = Bundle.main.path(forResource: asset, ofType: "png")
        {
            let stickerURL = URL(fileURLWithPath: stickerPath)
            let sticker : MSSticker
            do{
                try sticker = MSSticker(contentsOfFileURL: stickerURL, localizedDescription: localizedDescription)
                stickers.append(sticker)
            } catch{
                return
            }
        }
    }

    override func numberOfStickers(in stickerBrowserView: MSStickerBrowserView) -> Int {
        return stickers.count
    }

    override func stickerBrowserView(_ stickerBrowserView: MSStickerBrowserView, stickerAt index: Int) -> MSSticker {
        return stickers[index]
    }
    
}
