//
//  File.swift
//  
//
//  Created by P. Mark Anderson on 9/8/23.
//

import OctopusKit
import SwiftUI

public class GameState: State {
    let sceneKey: AnyKey?
    var view: AnyView?
//    let sceneFileName: String? // TODO: For scenes that should be loaded from .sks files
    
   public init(key: AnyKey, sceneKey: AnyKey? = nil) {
        if let sceneKey = sceneKey {
            self.sceneKey = sceneKey
        } else {
            // Use game state key
            self.sceneKey = key
        }
        
        super.init(key: key)
    }

    public convenience init(key: GameStateKey, sceneKey: SceneKey? = nil) {
        if let sceneKey = sceneKey {
            self.init(key: AnyKey(key), sceneKey: AnyKey(sceneKey))
        } else {
            self.init(key: AnyKey(key))
        }
    }

    public convenience init(key: String, sceneKey: AnyKey? = nil) {
        self.init(key: AnyKey(key), sceneKey: sceneKey)
    }

    public convenience init<V: View>(_ key: AnyKey, sceneKey: AnyKey? = nil, view: V) {
        self.init(key: key, sceneKey: sceneKey)
        self.view = AnyView(view)
    }
    
    public convenience init<V: View>(_ key: GameStateKey, sceneKey: SceneKey? = nil, view: V) {
        self.init(key: key, sceneKey: sceneKey)
        self.view = AnyView(view)
    }

        lazy var okGameState: OKGameState = {
        if let view = self.view {
            return OKGameState(
                associatedSceneClass: BaseScene.self,
                associatedSwiftUIView: view)
        } else {
            return OKGameState(associatedSceneClass: BaseScene.self)
        }
    }()

    var scene: Scene? {
        if let sid = self.sceneKey, let scene = SceneManager.shared.getScene(for: sid) {
            // Use overriding sceneIdentifier
            return scene
        }
        
        if let scene = SceneManager.shared.getScene(for: self.key) {
            // Use GameState's identifier for convenience
            return scene
        }
        
        return nil
    }
}

// TODO: figure out the best way to represent the relationship between game state keys and scene keys.
// Since scenes are constructed with a key that game states can reference, it's convenient when the game state key matches the scene key.
// However, there's not necessarily a one-to-one relationship between scenes and game states because a single scene could be used by multiple game states.
// I'd like to have 2 separate enums for scene and game states, but I'd also like to keep the DSL syntax clean for declaring game states and their associated scenes.

public enum GameStateKey: String, KeyProtocol {
    case launch
    case mainMenu
    case lobby
    case levelLoading
    case levelSelect
    case settings
    case playing
    case paused
    case failure
    case success
    case minorTransition
    case majorTransition
    case gameOver
    case gameWin
    case leaderboard
    case tutorial
    case cutscene
    case adPlaying
}
