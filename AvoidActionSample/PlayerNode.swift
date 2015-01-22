//
//  PlayerNode.swift
//  AvoidActionSample
//
//  Created by ALPEN on 2015/01/21.
//  Copyright (c) 2015年 alperithm. All rights reserved.
//

import SpriteKit

class PlayerNode: SKSpriteNode {
    
    enum NodeSettings: CGFloat {
        case speed = 1000.0
    }

    override init() {
        let texture = SKTexture(imageNamed: "kesaran.png")
        super.init(texture: texture, color: nil, size: CGSize(width: texture.size().width/3, height: texture.size().height/3))
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
