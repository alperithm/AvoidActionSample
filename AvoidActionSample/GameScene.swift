//
//  GameScene.swift
//  AvoidActionSample
//
//  Created by ALPEN on 2015/01/21.
//  Copyright (c) 2015年 alperithm. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    // ゲームモード
    enum GameStatus:Int {
        case kGamePlaying = 0,
        kGameOver
    }

    // オブジェクト名称
    enum ObjectName {
        case player

        func toString()->String{
            switch self {
            case .player:
                return "End"
            }
        }
    }

    // 各ステータス設定・初期化
    var score: Int = 0
    var gameStatus: Int = GameStatus.kGamePlaying.rawValue
    let player: PlayerNode = PlayerNode()
    var playerSpeed: CGFloat = PlayerNode.NodeSettings.speed.rawValue
    
    override func didMoveToView(view: SKView) {
        // プレーヤーのセット
        self.player.position = CGPoint(x: 500, y: 200)
        self.player.name = ObjectName.player.toString()
        self.addChild(player)
    }

    // タッチ時アクション
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
        let touch: AnyObject! = touches.anyObject()
        let location = touch.locationInNode(self)
        
        var y: CGFloat = location.y
        var diff: CGFloat = abs(y - self.player.position.y)
        var move: SKAction = SKAction.moveToY(y, duration: 1.0)
        self.player.runAction(move)
        
//        let touchedNode = self.nodeAtPoint(location)
//        
//        if touchedNode.name != nil {
//            if touchedNode.name == "End" {
//
//            }
//        } else {
//            
//            // 「End」以外のエリアをタップした場合は、スコアを「+1」する。
//            score += 1
//        }
    }
    
    // ゲームオーバー処理
    func gameOver() {
        // ユーザデフォルトにスコアを格納。
        let ud = NSUserDefaults.standardUserDefaults()
        ud.setInteger(score, forKey: "score")
        
        // 結果シーンに遷移させる。
        let newScene = ResultScene(size: self.scene!.size)
        newScene.scaleMode = SKSceneScaleMode.AspectFill
        self.view!.presentScene(newScene)
    }
    
    // 障害物の生成
    func addEnemy() {
        // ゲームオーバー時は生成しない
        if gameStatus != GameStatus.kGameOver.rawValue {
            
        }
    }
    
}
