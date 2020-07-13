//
//  MenuViewController.swift
//  PingPong
//
//  Created by Yauheni Bunas on 7/7/20.
//  Copyright © 2020 Yauheni Bunas. All rights reserved.
//

import UIKit

enum gameType {
    case easy
    case medium
    case hard
    case player2
}

class MenuViewController: UIViewController {
    
    @IBAction func player2(_ sender: Any) {
        moveToGame(game: .player2)
    }
    
    @IBAction func easyLevel(_ sender: Any) {
        moveToGame(game: .easy)
    }
    
    @IBAction func mediumLevel(_ sender: Any) {
        moveToGame(game: .medium)
    }
    
    @IBAction func hardLevel(_ sender: Any) {
        moveToGame(game: .hard)
    }
    
    func moveToGame(game: gameType) {
        let gameVC = self.storyboard?.instantiateViewController(identifier: "gameVC") as! GameViewController
        
        currentGameType = game
        
        self.navigationController?.pushViewController(gameVC, animated: true)
    }
}

