//
//  ContentView.swift
//  ExampleGameDSL2D
//
//  Created by P. Mark Anderson on 9/21/23.
//

import SwiftUI
import OctopusKit
import GameDSL2D
import SpriteKit

struct ContentView: View {
    var body: some View {
        Text("GameDSL2D")
        DSLGameView(game)
            .statusBar(hidden: true)
    }
}

func createShapeNode() -> SKNode {
    let placeholderShape = SKShapeNode(rectOf: CGSize(width: 150, height: 150))
    placeholderShape.strokeColor = SKColor.blue
    placeholderShape.fillColor = SKColor.lightGray
    placeholderShape.lineWidth = 4.0
    return placeholderShape
}

func createSpriteNode(from assetName: String) -> SKSpriteNode {
    // Load the texture
    let texture = SKTexture(imageNamed: assetName)
    
    // Create the sprite node from the texture
    let spriteNode = SKSpriteNode(texture: texture)
    
    // Set additional properties if needed (e.g., position, scale, etc.)
    // spriteNode.position = ...
     spriteNode.setScale(2)
    
    return spriteNode
}


let game = Game {
    Scene(key: .playing) {
        Entity(type: .player) {
            Components {[
                SpriteKitComponent(node: createSpriteNode(from: "knight1")),
            ]}
        }
        
        Entity(type: .enemy) {
            Components {[
                SpriteKitComponent(node: createShapeNode()),
            ]}
        }
    }
    GameState(.playing, view: PlayUI())
}

struct PlayUI: View {
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("PlayUI")
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
        .padding()
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
