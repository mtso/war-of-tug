//
//  GameState.swift
//  War of Tug
//
//  Created by Matthew Tso on 6/23/16.
//  Copyright © 2016 Matthew Tso. All rights reserved.
//

import UIKit
import GameplayKit

/** 
    This is the base GKState class that the other game states
    inherit from. Keeps a reference to the game's view controller.
*/
class GameState: GKState {

    unowned let controller: GameViewController
    
    init(game: GameViewController) {
        controller = game
    }
}
