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

    static let opponentTugInterval: TimeInterval = 1.0
    var tugTimeCounter: TimeInterval = 0    
    
    override func update(withDeltaTime seconds: TimeInterval) {
        tugTimeCounter += seconds
        
        if tugTimeCounter > GamePlayingState.opponentTugInterval {
            controller.tugAction(entity: .opponent)
            tugTimeCounter = 0
        }
    }
    
    override func willExit(withNextState nextState: GKState) {
        controller.threshold?.layer.transform = ZeroScaleX
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        switch stateClass {
        case is GameWinState.Type, is GameLoseState.Type:
            return true
            
        default:
            return false
        }
    }
    
}
