//
//  DSLGameCoordinator.swift
//  
//
//  Created by P. Mark Anderson on 9/23/23.
//

import OctopusKit

class DSLGameCoordinator: OctopusGameCoordinator {
    private var gameStates: [AnyKey: GameState] = [:]
    private var activeGameState: GameState?

    init(states: [GameState]) {
        // Use a single dummy state
        super.init(states: [OKGameState()], initialStateClass: OKGameState.self)
        for state in states {
            addState(state)
        }
    }

    func addState(_ gameState: GameState) {
        gameStates[gameState.key] = gameState
    }
    
    func enter(_ key: AnyKey) {
        guard let gameState = gameStates[key] else { return }
        
        if let scene = gameState.scene {
            scene.activate()
            // TODO: Additional logic to transition to the scene
        }
    }
    
    func changeState(to key: AnyKey) {
        guard let newState = gameStates[key] else { return }

        activeGameState?.triggerOnExit(to: key) // Call the willExit effect
        newState.triggerOnEnter(from: activeGameState?.key) // Call the didEnter effect

        activeGameState = newState
    }
    
//    private func enterStateWithScene(_ scene: BaseScene, andSwiftUIView view: AnyView) {
        // This method would be your way to transition to the given scene and view.
        // It will leverage the capabilities provided by OctopusGameCoordinator
        // and ensure the transition is smooth.
//    }
}
