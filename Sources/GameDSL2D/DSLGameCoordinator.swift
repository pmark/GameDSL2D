//
//  DSLGameCoordinator.swift
//  
//
//  Created by P. Mark Anderson on 9/23/23.
//

import OctopusKit

public class DSLGameCoordinator: OctopusGameCoordinator {
    private var gameStates: [AnyKey: GameState] = [:]
    private var activeGameState: GameState?
    
    init(states: [GameState]) {
        let okGameStates = states.compactMap { $0.okGameState }
        super.init(states: okGameStates, initialStateClass: OKGameState.self)
        
        for state in states {
            addState(state)
        }
    }
    
    func addState(_ gameState: GameState) {
        gameStates[gameState.key] = gameState
    }
    
    public func enterInitialState() {
        guard
            let firstState = gameStates.first,
            let skView = spriteKitView
        else { return }
        
        Scene.sceneSize = skView.bounds.size
        
        enter(firstState.key)
    }
    
    func enter(_ key: AnyKey) {
        guard let gameState = gameStates[key] else { return }
        
        if let scene = gameState.scene {
            print("Activating scene \(String(describing: gameState.sceneKey))")
            self.currentGameState = gameState.okGameState
            
            print("Entering \(gameState.key)")
            self.presentScene(scene.okScene)
            
            print("Activating scene \(String(describing: gameState.sceneKey))")
            scene.activate() // CHECK: possibly present first?
        } else {
            print("Game state \(gameState.key) has no scene")
        }
        
        activeGameState = gameState
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
