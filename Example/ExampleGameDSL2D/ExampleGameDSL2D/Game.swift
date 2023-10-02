//
//  Game.swift
//  ExampleGameDSL2D
//
//  Created by P. Mark Anderson on 9/21/23.
//

import GameDSL2D

class GameManager {
    let game = Game() {
        GameState(.mainMenu, ContentView()) {
            Scene(name: "Scene1") {
                Scenario(name: "Scenario1") {
                    Entity.player
                }
            }
        }
    }
    
}
