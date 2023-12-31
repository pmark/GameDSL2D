//
//  Scene.swift
//  
//
//  Created by P. Mark Anderson on 8/31/23.
//

import GameplayKit
import OctopusKit

public class Scene: BaseConstruct, Equatable, AutoEntityCreatable, Stateful {
    public var key: AnyKey
    public var scenarios: [Scenario] = []
    public var autoCreatedEntities: [Entity] = []
    public var states: [AnyKey: State] = [:]
    public var currentState: State?
    
    lazy var systems: [GKComponent.Type] = {
        systemsConstruct?.componentTypes ?? []
    }()
    
    public var systemsConstruct: Systems?
    
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
        systemsConstruct = children(ofType: Systems.self).last
    }
    
    func activateScenario(named name: String) {
        if let scenario = scenarios.first(where: { $0.name == name }) {
            activeScenario = scenario
        }
    }

    public override func onActivate() {
        // CHECK: should this be done last?
        print("--SCENE onActivate \(name) \(self.key)")
        super.onActivate()
        
        // Load the first scenario or a default scenario
        // TODO: determine which scenario should be active
        scenarios.first?.activate()
        
        // Attach systems to okScene
        systems.forEach { componentType in
            okScene.componentTypes.append(componentType)
        }
        
        // Populate scene with entities
        for entity in self.entities {
            addEntityToScene(entity.okEntity)
        }
        
        if let scene = self.sceneEntity?[SpriteKitSceneComponent.self]?.scene {
            assert(scene.isEqual(self.okScene), "Scene#okScene should be the SpriteKitSceneComponent's scene")
        }
        
        // Check if a camera is already set in the SKScene
//        if let scene = self.sceneEntity?[SpriteKitSceneComponent.self]?.scene, scene.camera == nil {
//            // Automatically add a DefaultCameraComponent if none exists
//            self.addComponent(DefaultCameraComponent.self)
//        }
    }
    
    public override func onDeactivate() {
        activeScenario?.deactivate()
        okScene.componentTypes = []
        
        // Populate scene with entities
        for entity in self.entities {
            self.okScene.removeEntity(entity.okEntity)
        }
        
        super.onDeactivate()
    }
    
    var sceneEntity: OKEntity? {
        self.okScene.entity as? OKEntity
    }
    
    func addEntityToScene(_ okEntity: OKEntity) {
        print("\n\nScene: adding entity \(okEntity)")
        self.okScene.addEntity(okEntity)
    }
    
    public func configure(_ configuration: (OKScene) -> Void) -> Self {
        configuration(okScene) 
        return self
    }
    
    public func onStateEnter(_ state: AnyKey, _ handler: @escaping () -> Void) -> Self {
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
