//
//  GameViewController.swift
//  PingPong
//
//  Created by Yauheni Bunas on 7/7/20.
//  Copyright © 2020 Yauheni Bunas. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

var currentGameType: gameType = .easy

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                scene.size = view.bounds.size
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
            
            let menuButton = UIBarButtonItem(title: "Menu", style: .plain, target: nil, action: nil)
            self.navigationController?.navigationBar.topItem?.backBarButtonItem = menuButton
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
