//
//  Scene.swift
//  
//
//  Created by P. Mark Anderson on 8/31/23.
//

import OctopusKit

public class Scene: BaseConstruct {
    var sceneIdentifier: GameIdentifier

    var scenarios: [Scenario] = []
    
    lazy var systems: [OKComponent.Type] = {
        systemConstruct?.componentTypes ?? []
    }()
    
    public var systemConstruct: Systems?
    
    var activeScenario: Scenario? {
        didSet {
            oldValue?.deactivate()
            activeScenario?.activate()
        }
    }
    
    lazy public var okScene: BaseScene = {
        // TODO: figure out scene size config
        let scene = BaseScene(size: .init(widthAndHeight: 1000)) //name: self.name ?? "UnnamedScene")
        return scene
    }()
    
    public init(sceneIdentifier: GameIdentifier, data: (() -> GameData)? = nil, @GameConstructBuilder childConstructs: () -> [Any]) {
        self.sceneIdentifier = sceneIdentifier
        super.init(name: "\(sceneIdentifier) scene", data: data, children: childConstructs())
    }
    
    public override func didInitialize() {
        SceneManager.shared.register(self, for: sceneIdentifier)
        scenarios = children(ofType: Scenario.self)
        systemConstruct = children(ofType: Systems.self).last
    }
    
    func activateScenario(named name: String) {
        if let scenario = scenarios.first(where: { $0.name == name }) {
            activeScenario = scenario
        }
    }

    public override func activate() {
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
