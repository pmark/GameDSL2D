//
//  Game.swift
//  ExampleGameDSL2D
//
//  Created by P. Mark Anderson on 9/21/23.
//

import GameDSL2D

class GameManager {
    let game = Game() {
        GameState(.mainMenu, view: ContentView())
        
        Scene(key: .mainMenu) {
            Scenario(name: "Scenario1") {
//                Entity.player
            }
        }
    }
    
}
