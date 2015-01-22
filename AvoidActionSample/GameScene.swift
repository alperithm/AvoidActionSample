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
    
    // 障害物生成ライン本数
    var enemyLine = 10
    
/**
*   処理定義
*/
    
    override func didMoveToView(view: SKView) {
        
        // シーン全体の物理演算設定
        self.physicsWorld.gravity = CGVectorMake(0, 0)
        self.physicsWorld.contactDelegate = self
        
        // プレーヤーのセット
        addPlayer()
        
        // 敵生成
        var timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "generateEnemy", userInfo: nil, repeats: true)
    }

    // タッチ時アクション
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
        let touch: AnyObject! = touches.anyObject()
        let location = touch.locationInNode(self)
        
        var y: CGFloat = location.y
        var diff: CGFloat = abs(y - self.player.position.y)
        var move: SKAction = SKAction.moveToY(y, duration: 1.0)
        self.player.runAction(move)
        
    }
    
    // オブジェクト衝突時
    func didBeginContact(contact: SKPhysicsContact) {
        println("Contct!")
        gameOver()
    }
    
    override func update(currentTime: NSTimeInterval) {
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
    
    // プレイヤーの生成
    func addPlayer() {
        self.player.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        self.player.name = ObjectName.player.toString()
        self.player.physicsBody?.categoryBitMask = playerCategory
        self.player.physicsBody?.contactTestBitMask = enemyCategory
        var pr: CGFloat = self.player.size.width / 2
        self.player.physicsBody = SKPhysicsBody(
            circleOfRadius: pr
        )
        self.addChild(player)
    }
    
    // 障害物ランダム生成
    func generateEnemy() {
        var randLine: CGFloat = CGFloat(arc4random_uniform(UInt32(enemyLine)))
        var randDirection: Int = Int(arc4random_uniform(UInt32(2)))
        addEnemy(self.size.height / CGFloat(enemyLine) * randLine , direction: randDirection)
    }
    
    // 障害物の生成
    func addEnemy(height: CGFloat, direction: Int) {
        // ゲームオーバー時は生成しない
        if gameStatus != GameStatus.kGameOver.rawValue {
            score++
            
            // ノード生成
            let enemy: EnemyNode = EnemyNode()
            enemy.position = CGPointMake(-enemy.size.width, height)
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
                move = SKAction.moveToX(moveX * -1 + self.size.width, duration: 1.0)
                enemy.position.x = self.size.width + enemy.size.width
            }
            var action: SKAction = SKAction.sequence([move, SKAction.removeFromParent()])
            enemy.runAction(action)
            self.addChild(enemy)
        }
    }
    
}
