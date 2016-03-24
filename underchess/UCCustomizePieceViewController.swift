//
//  UCCustomizePieceViewController.swift
//  Underchess
//
//  Created by Apollonian on 3/22/16.
//  Copyright © 2016 WWITDC. All rights reserved.
//

import UIKit

class UCCustomizePieceViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // FIXME: Add Feature Later
        UCArenaViewController.sharedInstance.needAnimation = false
        presentViewController(UCArenaViewController.sharedInstance, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
