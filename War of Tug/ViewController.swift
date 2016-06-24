//
//  ViewController.swift
//  War of Tug
//
//  Created by Matthew Tso on 6/23/16.
//  Copyright © 2016 Matthew Tso. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidAppear(animated: Bool) {
        
        let gameViewController = GameViewController()
        
        // Present the game's view controller.
        presentViewController(gameViewController, animated: false, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

