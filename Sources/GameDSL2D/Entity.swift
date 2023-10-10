import GameplayKit
import OctopusKit
import Foundation

public class Entity: BaseConstruct, Activatable {
    public let type: AnyKey
    public var componentInitializers: [ComponentInitializer] = []
    private var _okEntity: OKEntity? = nil
    
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
        self.init(type: AnyKey(type), name: name ?? "", data: data)
    }
    
    public init(type: AnyKey, name: String = "", data: (() -> GameData)? = nil) {
        self.type = type
        super.init(name: name, data: data, children: [])
    }
    
    public convenience init(type: EntityType, name: String? = nil, data: (() -> GameData)? = nil, @GameConstructBuilder childConstructs: () -> [Any]) {
        self.init(type: AnyKey(type), name: name, data: data, childConstructs: childConstructs)
    }
    
    public init(type: AnyKey, name: String? = nil, data: (() -> GameData)? = nil, @GameConstructBuilder childConstructs: () -> [Any]) {
        self.type = type
        super.init(name: name, data: data, children: childConstructs())
    }
   
    // Add single component by type with default initializer
    @discardableResult
    func addComponent<T>(_ componentType: T.Type) -> Self where T: ComponentType {
        self.componentInitializers.append(ComponentInitializer(single: { componentType.init() }))
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
        
        // Automatically register the entity for future use
        EntityFactory.shared.register(type: type, name: self.name, entity: self)
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
}

extension BaseConstruct {
    var entities: [Entity] {
        return children(ofType: Entity.self)
    }
}

public struct ComponentInitializer {
    let single: (() -> ComponentType)?
    let multi: (() -> [ComponentType])?
    
    init(single: (() -> ComponentType)? = nil, multi: (() -> [ComponentType])? = nil) {
        self.single = single
        self.multi = multi
    }
    
    func instantiate() -> [ComponentType] {
        var combined: [ComponentType] = []
        
        if let single = self.single {
            combined.append(single())
        }
        
        if let multi = self.multi {
            combined += multi()
        }
        
        return combined
    }
}
