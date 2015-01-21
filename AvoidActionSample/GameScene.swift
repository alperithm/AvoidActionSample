//
//  GameScene.swift
//  AvoidActionSample
//
//  Created by ALPEN on 2015/01/21.
//  Copyright (c) 2015年 alperithm. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var score: Int = 0
    
    override func didMoveToView(view: SKView) {
        
        score = 0
        
        // 便宜敵に「End」ボタンを作成。これでゲームを終了して結果シーンに移る仕様にする。
//        let endLabel = SKLabelNode(fontNamed: "Copperplate")
//        endLabel.text = "End"
//        endLabel.fontSize = 48
//        endLabel.position = CGPoint(x: 500, y: 200)
//        endLabel.name = "End"
//        self.addChild(endLabel)
        let player: SKSpriteNode = PlayerNode()
        player.position = CGPoint(x: 500, y: 200)
        player.name = "End"
        self.addChild(player)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
        let touch: AnyObject! = touches.anyObject()
        let location = touch.locationInNode(self)
        let touchedNode = self.nodeAtPoint(location)
        
        if touchedNode.name != nil {
            if touchedNode.name == "End" {
                
                // ユーザデフォルトにスコアを格納。
                let ud = NSUserDefaults.standardUserDefaults()
                ud.setInteger(score, forKey: "score")
                
                // 結果シーンに遷移させる。
                let newScene = ResultScene(size: self.scene!.size)
                newScene.scaleMode = SKSceneScaleMode.AspectFill
                self.view!.presentScene(newScene)
            }
        } else {
            
            // 「End」以外のエリアをタップした場合は、スコアを「+1」する。
            score += 1
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
    }
}
