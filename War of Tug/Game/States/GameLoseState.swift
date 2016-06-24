//
//  GameLoseState.swift
//  War of Tug
//
//  Created by Matthew Tso on 6/24/16.
//  Copyright © 2016 Matthew Tso. All rights reserved.
//

import UIKit
import GameplayKit

class GameLoseState: GameState {

    override func didEnterWithPreviousState(previousState: GKState?) {
        let extend = CATransform3DMakeScale(1, 1, 1)
        
        UIView.animateWithDuration(0.5, delay: 0, options: .CurveEaseIn, animations: {
            
            self.controller.rope?.frame.origin.y = self.controller.view.frame.origin.y - self.controller.rope!.frame.height
            
            self.controller.button?.layer.transform = extend
            
            }, completion: { _ in
                self.stateMachine?.enterState(GameTransitionState)
        })

        var lose_title: String?
        if let asset = NSDataAsset(name: "lose_title") {
            lose_title = String(data: asset.data, encoding: NSUTF8StringEncoding)
        }
        
        controller.button?.setTitle(lose_title, forState: .Normal)

    }

    override func isValidNextState(stateClass: AnyClass) -> Bool {
        return stateClass is GameTransitionState.Type
    }
}
