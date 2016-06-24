//
//  GameState.swift
//  War of Tug
//
//  Created by Matthew Tso on 6/23/16.
//  Copyright © 2016 Matthew Tso. All rights reserved.
//

import UIKit
import GameplayKit

class GameState: GKState {

    unowned let controller: GameViewController
    
    init(game: GameViewController) {
        controller = game
    }
}
