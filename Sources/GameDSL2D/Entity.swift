import GameplayKit
import OctopusKit
import Foundation

public class Entity: BaseConstruct, Activatable {
    public let type: AnyKey
    public var componentInitializers: [ComponentInitializer] = []
    private var _okEntity: OKEntity? = nil
    public var states: [AnyKey: State] = [:]
    public var currentState: State?
    
    public var identifier: EntityIdentifier {
        EntityIdentifier(type: self.type, name: self.name)
    }
    
    public lazy var okEntity: OKEntity = {
        guard let okEntity = _okEntity else {
            return self.instantiate()
        }
        return okEntity
    }()
         
    private(set) lazy var components: [ComponentType] = {
        componentInitializers.flatMap { $0.instantiate() }
    }()
   
    public convenience init(type: EntityType, name: String? = nil, data: (() -> GameData)? = nil) {
//        var extant: Entity? = nil
//        if data == nil {
//            extant = EntityRegistry.shared.findEntity(ofType: type, withName: name)
//        }
        
        self.init(type: AnyKey(type), name: name, data: data)
    }
    
    public init(type: AnyKey, name: String? = nil, data: (() -> GameData)? = nil) {
        // TODO: Use extant entity if already registered and data is not given
//        var extant: Entity? = nil
        
//        if data == nil {
//            extant = EntityRegistry.shared.findEntity(ofType: type, withName: name)
//        }
            
        self.type = type
        super.init(name: name, data: data, children: [])
        
//        self.merge(extant)
    }
    
    public convenience init(type: EntityType, name: String? = nil, data: (() -> GameData)? = nil, @GameConstructBuilder childConstructs: () -> [Any]) {
        self.init(type: AnyKey(type), name: name, data: data, childConstructs: childConstructs)
    }
    
    public init(type: AnyKey, name: String? = nil, data: (() -> GameData)? = nil, @GameConstructBuilder childConstructs: () -> [Any]) {
        self.type = type
        super.init(name: name, data: data, children: childConstructs())
    }
        
    private func merge(_ extant: Entity?) {
        guard let extant = extant else { return }
        self.data = extant.data
        self.children = extant.children
        self.componentInitializers = extant.componentInitializers
        self._okEntity = extant._okEntity
    }
   
    // Add single component by type with default initializer
    @discardableResult
    func addComponent<T>(_ componentType: T.Type) -> Self where T: ComponentType {
        self.componentInitializers.append(ComponentInitializer(type: componentType))
        return self
    }
    
    // Add single component with a custom initializer
    @discardableResult
    func addComponent<T>(_ initializer: @escaping () -> T) -> Self where T: ComponentType {
        self.componentInitializers.append(ComponentInitializer(single: initializer))
        return self
    }
    
    // Use a block that contains an array of component initializers
    // See Components constructs
    @discardableResult
    func addComponents(_ batch: @escaping () -> [ComponentType]) -> Self {
        self.componentInitializers.append(ComponentInitializer(multi: batch))
        return self
    }
    
    public override func didInitialize() {
        // Extracting the `Components` constructs from the children
        let componentsConstructs = children.compactMap({ $0 as? Components })
        for construct in componentsConstructs {
            self.addComponents(construct.componentsClosure)
        }
        
        let stateConstructs = children(ofType: State.self)
        for state in stateConstructs {
            self.states[state.key] = state
        }

        // Automatically register the entity for future use
        EntityRegistry.shared.register(type: type, name: self.name, entity: self)
    }
    
//    public static func create(type: EntityType, name: String? = "") -> OKEntity? {
//        return create(type: AnyKey(type), name: name)
//    }
    
//    public static func create(type: AnyKey, name: String? = "") -> OKEntity? {
//        return EntityFactory.shared.create(type: type, name: name)
//    }
    
    private func instantiate() -> OKEntity {
        // Logic to create and configure a new OKEntity instance
        let newOKEntity = OKEntity()
        newOKEntity.name = "\(self.type) \(self.name)"
        newOKEntity.addComponents(self.components)
        _okEntity = newOKEntity
        return newOKEntity
    }
    
    private func uninstantiate() {
        self._okEntity = nil
    }
    
    public override func onDeactivate() {
        super.onDeactivate()
        uninstantiate()
    }
    
    public func getSceneComponent() -> SpriteKitSceneComponent? {
        self.okEntity[SpriteKitSceneComponent.self]
    }
    
    public func getScene() -> OKScene? {
        getSceneComponent()?.scene
    }
}

extension BaseConstruct {
    var entities: [Entity] {
        return children(ofType: Entity.self)
    }
    
    func firstEntity(withIdentifier identifier: EntityIdentifier) -> Entity? {
        self.entities.first { entity in
            entity.identifier == identifier
        }
    }
}

public struct ComponentInitializer {
    let type: ComponentType.Type?
    let single: (() -> ComponentType)?
    let multi: (() -> [ComponentType])?
    
    init(type: ComponentType.Type? = nil, single: (() -> ComponentType)? = nil, multi: (() -> [ComponentType])? = nil) {
        self.type = type
        self.single = single
        self.multi = multi
    }
    
    func instantiate() -> [ComponentType] {
        var combined: [ComponentType] = []
        
        if let type = self.type {
            combined.append(type.init())
        }
        
        if let single = self.single {
            combined.append(single())
        }
        
        if let multi = self.multi {
            combined += multi()
        }
        
        return combined
    }
}
