//
//  EnemyNode.swift
//  AvoidActionSample
//
//  Created by ALPEN on 2015/01/22.
//  Copyright (c) 2015年 alperithm. All rights reserved.
//

import SpriteKit

class EnemyNode: SKSpriteNode {
    
    enum EnemyName {
        case Cyber
        
        func toString()->String{
            switch self {
            case .Cyber:
                return "cyber_enemy.png"
            }
        }
    }
    
    enum NodeSettings: CGFloat {
        case speed = 0.4
    }
    
    override init() {
        let texture = SKTexture(imageNamed: EnemyName.Cyber.toString())
        super.init(texture: texture, color: nil, size: CGSize(width: texture.size().width/3, height: texture.size().height/3))
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
