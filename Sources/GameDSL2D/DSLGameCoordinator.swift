//
//  DSLGameCoordinator.swift
//  
//
//  Created by P. Mark Anderson on 9/23/23.
//

import OctopusKit

class DSLGameCoordinator: OctopusGameCoordinator {
    private var gameStates: [GameIdentifier: GameState] = [:]

    func addState(_ gameState: GameState) {
        gameStates[gameState.identifier] = gameState
    }
    
    func enter(_ identifier: GameIdentifier) {
        guard let gameState = gameStates[identifier] else { return }
        
        if let scene = gameState.scene {
            scene.activate()
            // TODO: Additional logic to transition to the scene
        }
    }
    
//    private func enterStateWithScene(_ scene: BaseScene, andSwiftUIView view: AnyView) {
        // This method would be your way to transition to the given scene and view.
        // It will leverage the capabilities provided by OctopusGameCoordinator
        // and ensure the transition is smooth.
//    }
}
