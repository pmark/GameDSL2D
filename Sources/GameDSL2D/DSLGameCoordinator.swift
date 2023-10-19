//
//  DSLGameCoordinator.swift
//  
//
//  Created by P. Mark Anderson on 9/23/23.
//

import OctopusKit
import SpriteKit

public class DSLGameCoordinator: OctopusGameCoordinator {
    public var gameStates: [GameState] = []
    
    public var activeGameState: GameState? {
        didSet {
            oldValue?.triggerOnExit(to: activeGameState?.key) // Call the willExit effect
            activeGameState?.triggerOnEnter(from: oldValue?.key) // Call the didEnter effect
        }
    }
    
    init(states: [GameState]) {
        let okGameStates = states.compactMap { $0.okGameState }
        super.init(states: okGameStates, initialStateClass: OKGameState.self)
        self.gameStates = states

        if let skView = spriteKitView {
            // CHECK: is the timing right?
            
            print("TODO: if scene size is wrong, look here")
            Scene.sceneSize = skView.bounds.size
        }
    }
    
    public func addState(_ gameState: GameState) {
        print("adding game state \(gameState.key)")
        gameStates.append(gameState)
    }
    
    public func enterInitialState() {
        guard
            let firstState = gameStates.first
//            let skView = spriteKitView
        else { return }
        
//        Scene.sceneSize = skView.bounds.size
        
        print("\n\n enter first state \(firstState.key)\n\n")
        enterState(firstState.key)
    }
    
    public func enterState(_ key: GameStateKey) {
        self.enterState(AnyKey(key))
    }
    
    private func findState(_ key: AnyKey) -> GameState? {
        gameStates.first { $0.key == key }
    }
    
    public func enterState(_ key: String) {
        enterState(AnyKey(key))
    }
    
    public func enterState(_ key: AnyKey) {
        print("[DSL] entering game state \(key)")
        guard let gameState = findState(key) else { return }
        print("[DSL] found game state \(gameState.key)")
        
        self.enter(type(of: gameState.okGameState))
        
        if let scene = gameState.scene {
            print("Activating scene \(String(describing: gameState.sceneKey))")
            self.currentGameState = gameState.okGameState
            
            print("Entering \(gameState.key)")
            self.presentScene(scene.okScene)
            
            print("Activating scene \(String(describing: gameState.sceneKey))")
            scene.activate() // CHECK: possibly present first?
        } else {
            print("Game state \(gameState.key) has no scene")
            
            // TODO: clear scene
        }
        
        activeGameState = gameState
    }
    
    //    private func enterStateWithScene(_ scene: BaseScene, andSwiftUIView view: AnyView) {
    // This method would be your way to transition to the given scene and view.
    // It will leverage the capabilities provided by OctopusGameCoordinator
    // and ensure the transition is smooth.
    //    }
}

protocol SpriteKitViewProvider {
    func getSpriteKitView() -> SKView?
}

extension DSLGameCoordinator: SpriteKitViewProvider {
    func getSpriteKitView() -> SKView? {
        return self.spriteKitView
    }
}
