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
        Entity(type: .player, name: "Player") {
            Components {[
                SpriteKitComponent(node: createSpriteNode(from: "knight1")),
            ]}
        }
        
        Entity(type: .enemy, name: "Enemy") {
            Components {[
                SpriteKitComponent(node: createShapeNode()),
            ]}
        }
    }
    
    GameState(.mainMenu, sceneKey: .playing, view: MainMenuView())
    GameState(.playing, view: PlayUI())
    
    // TODO: Transition from .mainMenu to .playing
}

struct PlayUI: View {
    @EnvironmentObject var gameCoordinator: DSLGameCoordinator
    
    var body: some View {
        VStack {
            HStack {
                Button("Menu") {
                    gameCoordinator.enterState(.mainMenu)
                }
                .padding()
                .background(Color(red: 0.8, green: 0, blue: 0.5))
                .clipShape(Capsule())

                
                Spacer()
                Text("PlayUI")
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
        .padding()
    }
}

struct MainMenuView: View {
    @EnvironmentObject var gameCoordinator: DSLGameCoordinator
    
    var body: some View {
        VStack {
            HStack {
                Button("Play") {
                    print("Play button clicked")
                    gameCoordinator.enterState(.playing)
                }
                .padding()
                .background(Color(red: 0.8, green: 0, blue: 0.5))
                .clipShape(Capsule())
            }
            Spacer()
        }
        .background(Color.red)
        .padding()
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
