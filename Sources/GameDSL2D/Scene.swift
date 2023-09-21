//
//  File.swift
//  
//
//  Created by P. Mark Anderson on 8/31/23.
//

import Foundation
import OctopusKit

class Scene: BaseConstruct {
    var scenarios: [Scenario] = []
    
    lazy var systems: [OKComponent.Type] = {
        systemConstruct?.componentTypes ?? []
    }()
    
    public var systemConstruct: Systems?
    
    var activeScenario: Scenario? {
        didSet {
//            oldValue?.deactivate()
//            activeScenario?.activate()
        }
    }
    
    lazy public var okScene: BaseScene = {
        // TODO: figure out scene size config
        let scene = BaseScene(size: .init(widthAndHeight: 1000)) //name: self.name ?? "UnnamedScene")
        return scene
    }()
    
    override func didInitialize() {
        scenarios = children(ofType: Scenario.self)
        systemConstruct = children(ofType: Systems.self).last
    }
    
    func activateScenario(named name: String) {
        if let scenario = scenarios.first(where: { $0.name == name }) {
            activeScenario = scenario
        }
    }

    override func activate() {
        // Load the first scenario or a default scenario
        // TODO: determine which scenario should be active
        scenarios.first?.activate()
        
        // Attach systems to okScene
        systems.forEach { componentType in
            okScene.componentTypes.append(componentType)
        }
        
        // TODO: populate scene
        
        // Activation logic for the scene can go here
        // For example, presenting it
    }
}
