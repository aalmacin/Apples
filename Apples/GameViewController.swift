//
//  GameViewController.swift
//  Apples
//
//  Created by Aldrin Jerome Almacin on 2015-04-04.
//  Copyright (c) 2015 Almacin. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create a SpriteKit view object which will show all the sprites on the page
        let skView = self.view as SKView
        skView.showsFPS = false
        skView.showsNodeCount = false
        
        skView.ignoresSiblingOrder = true
        
        // Create the main game scene and make it the default scene to show after the splash screen
        let scene = MainGameScene(size: view.bounds.size)
        scene.scaleMode = .AspectFill
        skView.presentScene(scene)
    }
}
