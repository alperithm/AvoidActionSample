//
//  GameScene.swift
//  AvoidActionSample
//
//  Created by ALPEN on 2015/01/21.
//  Copyright (c) 2015年 alperithm. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
/**
*   データ定義
*/
    
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
    
    // オブジェクト移動方向
    enum Direction: Int {
        case right = 0,
        left,
        up,
        down
    }
    
    // 各ステータス設定・初期化
    var score: Int = 0
    var gameStatus: Int = GameStatus.kGamePlaying.rawValue
    let player: PlayerNode = PlayerNode()
    var playerSpeed: CGFloat = PlayerNode.NodeSettings.speed.rawValue
    
    // 衝突カテゴリ
    let playerCategory: UInt32 = 0x1<<0
    let enemyCategory: UInt32 = 0x1<<1
    
/**
*   処理定義
*/
    
    override func didMoveToView(view: SKView) {
        
        // シーン全体の物理演算設定
        self.physicsWorld.gravity = CGVectorMake(0, 0)
        self.physicsWorld.contactDelegate = self
        
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
        
        
        addEnemy(CGPointMake(-20, 100), direction: Direction.right.rawValue)
        
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
    
    override func update(currentTime: NSTimeInterval) {
        if currentTime % 10 == 0 {
            addEnemy(CGPointMake(-50, 100), direction: Direction.right.rawValue)
        }
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
    func addEnemy(point: CGPoint, direction: Int) {
        // ゲームオーバー時は生成しない
        if gameStatus != GameStatus.kGameOver.rawValue {
            score++
            
            // ノード生成
            let enemy: EnemyNode = EnemyNode()
            enemy.position = point
            enemy.speed = EnemyNode.NodeSettings.speed.rawValue
            var pr: CGFloat = enemy.size.width / 2
            enemy.physicsBody = SKPhysicsBody(
                circleOfRadius: pr
            )
            
            // 衝突設定
            enemy.physicsBody?.contactTestBitMask = playerCategory
            enemy.physicsBody?.categoryBitMask = enemyCategory
            enemy.physicsBody?.collisionBitMask = playerCategory
            
            // 障害物の動き
            var moveX: CGFloat = self.size.height
            var move: SKAction
            if direction == Direction.right.rawValue {
                move = SKAction.moveToX(moveX, duration: 1.0)
            } else {
                move = SKAction.moveToX(moveX * -1, duration: 1.0)
            }
            var action: SKAction = SKAction.sequence([move, SKAction.removeFromParent()])
            enemy.runAction(action)
            self.addChild(enemy)
        }
    }
    
}
