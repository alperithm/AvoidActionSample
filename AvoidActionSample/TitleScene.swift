//
//  TitleScene.swift
//  AvoidActionSample
//
//  Created by ALPEN on 2015/01/21.
//  Copyright (c) 2015年 alperithm. All rights reserved.
//

import SpriteKit

class TitleScene: SKScene {
    
    override func didMoveToView(view: SKView) {
        
        // タイトルを表示。
        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
        myLabel.text = "Avoid Action!!"
        myLabel.fontSize = 48
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        self.addChild(myLabel)
        
        // 「Start」を表示。
        let startLabel = SKLabelNode(fontNamed: "Copperplate")
        startLabel.text = "Start"
        startLabel.fontSize = 36
        startLabel.position = CGPoint(x: CGRectGetMidX(self.frame), y: 200)
        startLabel.name = "Start"
        self.addChild(startLabel)
    }
    
    // 「Start」ラベルをタップしたら、GameSceneへ遷移させる。
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
        let touch: AnyObject! = touches.anyObject()
        let location = touch.locationInNode(self)
        let touchedNode = self.nodeAtPoint(location)
        
        if touchedNode.name != nil {
            if touchedNode.name == "Start" {
                let newScene = GameScene(size: self.scene!.size)
                newScene.scaleMode = SKSceneScaleMode.AspectFill
                self.view!.presentScene(newScene)
            }
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
    
    }
}
