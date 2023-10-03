//
//  Scene.swift
//  
//
//  Created by P. Mark Anderson on 8/31/23.
//

import GameplayKit
import OctopusKit

public class Scene: BaseConstruct, Equatable {
    var key: AnyKey

    var scenarios: [Scenario] = []
    
    lazy var systems: [GKComponent.Type] = {
        systemConstruct?.componentTypes ?? []
    }()
    
    public var systemConstruct: Systems?
    
    var activeScenario: Scenario? {
        didSet {
            oldValue?.deactivate()
            activeScenario?.activate()
        }
    }
    
    public static func == (lhs: Scene, rhs: Scene) -> Bool {
        lhs.key == rhs.key
    }
    
    static var sceneSize = CGSize.init(width: 430, height: 932)
    
    lazy public var okScene: BaseScene = {
        let scene = BaseScene(size: Self.sceneSize)
        return scene
    }()
    
    public init(key: AnyKey, data: (() -> GameData)? = nil, @GameConstructBuilder childConstructs: () -> [Any]) {
        self.key = key
        super.init(name: "\(key.stringValue) scene", data: data, children: childConstructs())
    }
    
    public convenience init(key: SceneKey, data: (() -> GameData)? = nil, @GameConstructBuilder childConstructs: () -> [Any]) {
        self.init(key: AnyKey(key), data: data, childConstructs: childConstructs)
    }
    
    public init(key: AnyKey, data: (() -> GameData)? = nil) {
        self.key = key
        super.init(name: "\(key.stringValue) scene", data: data, children: [])
    }
    
    public convenience init(key: SceneKey, data: (() -> GameData)? = nil) {
        self.init(key: AnyKey(key), data: data)
    }
    
    public override func didSetParent() {
        SceneManager.shared.register(self, for: key)
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
        
        // Populate scene with entities
        for entity in self.entities {
            if let okEntity = Entity.create(type: entity.type, name: entity.name) {
                addEntityToScene(okEntity)
            }
        }
        
        // TODO: present scene?
    }
    
    func addEntityToScene(_ okEntity: OKEntity) {
        print("\n\nScene: adding entity \(okEntity)")
        self.okScene.addEntity(okEntity)
    }
    
    public func configure(_ configuration: (OKScene) -> Void) -> Self {
        configuration(okScene) 
        return self
    }
    
    public func onStateEnter(_ state: StateKey, _ handler: @escaping () -> Void) -> Self {
        // Handle state entering
        // ...
        return self
    }
}

public enum SceneKey: String, KeyProtocol {
    case mainMenu
    case lobby
    case levelSelect
    case worldMap
    case settings
    case playing
    case paused
    case failure
    case success
    case cutscene
    case complete
}
