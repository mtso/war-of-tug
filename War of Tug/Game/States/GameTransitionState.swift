//
//  GameTransitionState.swift
//  War of Tug
//
//  Created by Matthew Tso on 6/24/16.
//  Copyright © 2016 Matthew Tso. All rights reserved.
//

import UIKit
import GameplayKit

class GameTransitionState: GameState {
    
    static let transitionInterval: NSTimeInterval = 2.0
    var transitionTimeCounter: NSTimeInterval = 0
    
    var particleEmitter: CAEmitterLayer?

    override func didEnterWithPreviousState(previousState: GKState?) {
        if previousState is GameWinState {
            particleEmitter = CAEmitterLayer()
            particleEmitter?.emitterPosition = controller.view.center
            particleEmitter?.emitterSize = controller.view.frame.size
            particleEmitter?.emitterShape = kCAEmitterLayerRectangle
            
            let particle = CAEmitterCell()
            particle.birthRate = 25
            particle.lifetime = 1
            particle.lifetimeRange = 0.5
            particle.color = UIColor.grayColor().CGColor
            particle.spinRange = 6
            particle.scaleSpeed = -0.1
            particle.emissionLongitude = 6
            particle.emissionLatitude = 6
            particle.emissionRange = 6
            particle.scale = 0.5
            particle.velocity = 300
            particle.yAcceleration = 300
            particle.contents = UIImage(named: "tug_particle")?.CGImage
            
            particleEmitter?.emitterCells = [particle]
            
            controller.view.layer.insertSublayer(particleEmitter!, atIndex: 0)
        }
    }
    
    override func isValidNextState(stateClass: AnyClass) -> Bool {
        return stateClass is GameStartState.Type
    }
    
    override func updateWithDeltaTime(seconds: NSTimeInterval) {
        transitionTimeCounter += seconds
        
        if transitionTimeCounter > GameTransitionState.transitionInterval {
            transitionTimeCounter = 0
            
            particleEmitter?.removeFromSuperlayer()
            
            stateMachine?.enterState(GameStartState.self)
        }
        else if transitionTimeCounter > GameTransitionState.transitionInterval / 2 {
            particleEmitter?.birthRate = 0
        }
    }
    
}
