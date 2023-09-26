//
//  File.swift
//  
//
//  Created by P. Mark Anderson on 8/29/23.
//

import Foundation
import OctopusKit

public class SceneManager {
    static let shared = SceneManager()

    var currentScene: Scene?
    var activeEntities: [Entity] = []
    private var scenes: [GameIdentifier: Scene] = [:]
    
    private init() {
    }
    
    public func reset() {
        scenes = [:]
    }
    
    func register(_ scene: Scene, for identifier: GameIdentifier) {
        scenes[identifier] = scene
    }
    
    func getScene(for identifier: GameIdentifier) -> Scene? {
        return scenes[identifier]
    }
    
    func addEntity(_ entity: Entity) {
        activeEntities.append(entity)
    }
    
    func removeEntity(_ entity: Entity) {
        activeEntities.removeAll { $0 === entity }
    }
    
    func updateSystems(deltaTime: TimeInterval) {
//        let systems: [Systems] = []
//        for system in systems {
//            system.update(deltaTime: deltaTime, sceneManager: self)
//        }
    }
    
    func activate(scene: Scene) {
        // Handle scene activation logic
    }

    func deactivateCurrentScene() {
        // Handle scene deactivation logic
    }

    func add(scenario: Scenario) {
        // Add a scenario to the current scene
    }

    func remove(scenario: Scenario) {
        // Remove a scenario from the current scene
    }

    func update() {
        // Update the current scene and active scenarios
    }
}


/*
public class SceneManager {
    var currentScene: OKSceneWrapper<OKScene>?
    var activeEntities: [Entity] = []
    var systems: [OKComponentSystem] = []

    
    func createScene<T: OKScene>(ofType type: T.Type) -> OKSceneWrapper<T> {
        let scene = OKSceneWrapper<T>()
        scene.sceneManager = self
        self.currentScene = scene
        return scene
    }
    
    func populateScene(_ scene: OKScene) {
        // Populate the OKScene with entities, nodes, etc.
        for entity in activeEntities {
            // Logic to add entity to scene (e.g., adding SKNode to scene's node tree)
        }
    }
    
    func componentSystems() -> [OKComponentSystem] {
        return systems
    }
    
    // ... rest of the SceneManager logic remains mostly unchanged
    
    //
    var systemsConstruct: Systems?
    
    func createSceneWithDelegate<T: OKScene>(ofType type: T.Type) -> OKScene {
        let scene = T()
        let _ = OKSceneDelegateWrapper(scene: scene, manager: self)
        return scene
    }
}
*/
