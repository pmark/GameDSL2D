//
//  File.swift
//  
//
//  Created by P. Mark Anderson on 8/31/23.
//

import Foundation

class Scene: BaseConstruct {
    var scenarios: [Scenario] = []
    var systems: Systems?
    
    public var systemConstructs: [Systems] = []
    
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
        systems = children(ofType: Systems.self).last
        
        // Attach systems to okScene
        systems?.componentTypes.forEach { componentType in
            okScene.componentTypes.append(componentType)
        }
    }
    
    func activateScenario(named name: String) {
        if let scenario = scenarios.first(where: { $0.name == name }) {
            activeScenario = scenario
        }
    }

    override func activate() {
        super.activate()
        
        // Activation logic for the scene can go here
        // For example, presenting it
    }
}
