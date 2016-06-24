//
//  GamePlayingState.swift
//  War of Tug
//
//  Created by Matthew Tso on 6/24/16.
//  Copyright © 2016 Matthew Tso. All rights reserved.
//

import UIKit
import GameplayKit

class GamePlayingState: GameState {

    static let opponentTugInterval: NSTimeInterval = 1.0
    var tugTimeCounter: NSTimeInterval = 0    
    
    override func updateWithDeltaTime(seconds: NSTimeInterval) {
        tugTimeCounter += seconds
        
        if tugTimeCounter > GamePlayingState.opponentTugInterval {
            controller.tugAction(entity: .Opponent)
            tugTimeCounter = 0
        }
    }
    
    override func willExitWithNextState(nextState: GKState) {
        controller.threshold?.layer.transform = ZeroScaleX
    }
    
    override func isValidNextState(stateClass: AnyClass) -> Bool {
        switch stateClass {
        case is GameWinState.Type, is GameLoseState.Type:
            return true
            
        default:
            return false
        }
    }
    
}
