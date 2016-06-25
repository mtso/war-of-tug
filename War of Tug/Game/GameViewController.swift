//
//  GameViewController.swift
//  War of Tug
//
//  Created by Matthew Tso on 6/23/16.
//  Copyright © 2016 Matthew Tso. All rights reserved.
//

import UIKit
import GameplayKit

let NormalScale = CATransform3DMakeScale(1, 1, 1)
let ZeroScaleX  = CATransform3DMakeScale(0.001, 1, 1)
let ZeroScaleY  = CATransform3DMakeScale(1, 0.001, 1)

class GameViewController: UIViewController {

    /**
        Controls the state of the game. This is not modified 
        after it is configured in `viewDidLoad()`.
    */
    var stateMachine: GKStateMachine!
    
    /** 
        Multipurpose game beginning button that 
        also serves as the game over text label.
     */
    var button: UIButton?
    var rope: UIImageView?
    var threshold: UIImageView?

    /// The `CADisplayLink` object that calls the update loop.
    var displayLink: CADisplayLink!
    var previousUpdateTime: TimeInterval = 0
    
    /// Used to determine who is tugging.
    enum Entity {
        case player
        case opponent
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        // Set up CADisplayLink for the game update loop.
        displayLink = CADisplayLink(target: self, selector: #selector(update))
        displayLink.add(to: RunLoop.main(), forMode: RunLoopMode.defaultRunLoopMode.rawValue)
        
        view.backgroundColor = UIColor.white()
        
        button = UIButton(type: UIButtonType.system)
        button?.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
        button?.backgroundColor = UIColor.gray()
        button?.setTitleColor(UIColor.white(), for: UIControlState())

        rope = UIImageView(image: UIImage(named: "rope"))
        threshold = UIImageView(image: UIImage(named: "threshold"))
        
        button?.alpha = 0
        rope?.alpha = 0
        
        view.addSubview(threshold!)
        view.addSubview(rope!)
        view.addSubview(button!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Creates and adds states to the game's state machine.
        stateMachine = GKStateMachine(states: [
            GameStartState(game: self),
            GamePlayingState(game: self),
            GameWinState(game: self),
            GameLoseState(game: self),
            GameTransitionState(game: self),
        ])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Enter GameStartState after view appears 
        // because of the intro animation to the play button.
        stateMachine.enterState(GameStartState.self)
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        switch stateMachine.currentState {
        case is GamePlayingState:
            tugAction(entity: .player)

        default:
            break
        }
    }
    
    func buttonClick() {
        stateMachine.enterState(GamePlayingState.self)
    }
    
    /// Returns a tug action in a direction based on who is tugging.
    func tugAction(entity who: Entity) -> () {
        
        let tugDistance: CGFloat = 20

        func tugAction() {
            UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseOut, animations: {
                
                let tugDirection = who == .player ? tugDistance : -tugDistance
                self.rope!.frame.origin.y += tugDirection
                
                }, completion: { _ in
                    self.checkGameOver()
            })
        }
        return tugAction()
    }
    
    func checkGameOver() {
        if rope?.frame.origin.y > threshold?.frame.origin.y {
            stateMachine.enterState(GameWinState)
        } else if rope!.frame.origin.y + rope!.frame.height < threshold!.frame.origin.y + threshold!.frame.height {
            stateMachine.enterState(GameLoseState)
        }
    }
    
    func update() {
        let timeSincePreviousUpdate = displayLink.timestamp - previousUpdateTime
        previousUpdateTime = displayLink.timestamp

        stateMachine.update(withDeltaTime: timeSincePreviousUpdate)
    }

}
