//
//  File.swift
//  
//
//  Created by P. Mark Anderson on 8/31/23.
//

import Foundation

class Scene: BaseConstruct {
    var scenarios: [Scenario] = []
    var systems: Systems?  // Store the Systems construct
    
    var activeScenario: Scenario? {
        didSet {
//            oldValue?.deactivate()
//            activeScenario?.activate()
        }
    }
    
    lazy public var okScene: BaseScene = {
        // TODO: figure out scene size config
        let scene = BaseScene(size: .init(widthAndHeight: 1000)) //name: self.name ?? "UnnamedScene")
        scene.componentTypes = systems?.componentTypes ?? []
        scene.scenarios = self.scenarios
        return scene
    }()
    
    override func didSetParent() {
        scenarios = children.compactMap { $0 as? Scenario }
        systems = children.compactMap { $0 as? Systems }.first  // There should be only one Systems construct
    }
    
    func activateScenario(named name: String) {
        if let scenario = scenarios.first(where: { $0.name == name }) {
            activeScenario = scenario
        }
    }
}
