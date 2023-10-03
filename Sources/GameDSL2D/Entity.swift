import GameplayKit
import OctopusKit
import Foundation

public class Entity: BaseConstruct, Activatable {
    public let type: AnyKey
    public var singleComponents: [GKComponent] = []
    public var componentsConstructs: [Components] = []
    
    public convenience init(type: EntityType, name: String = "", data: (() -> GameData)? = nil) {
        self.init(type: AnyKey(type), name: name, data: data)
    }
    
    public init(type: AnyKey, name: String = "", data: (() -> GameData)? = nil) {
        self.type = type
        super.init(name: name, data: data, children: [])
    }
    
    public convenience init(type: EntityType, name: String = "", data: (() -> GameData)? = nil, @GameConstructBuilder childConstructs: () -> [Any]) {
        self.init(type: AnyKey(type), name: name, data: data, childConstructs: childConstructs)
    }
    
    public init(type: AnyKey, name: String = "", data: (() -> GameData)? = nil, @GameConstructBuilder childConstructs: () -> [Any]) {
        self.type = type
        super.init(name: name, data: data, children: childConstructs())
    }
    
    private(set) lazy var components: [GKComponent] = {
        var allComponents: [GKComponent] = []
        for construct in componentsConstructs {
            allComponents.append(contentsOf: construct.instantiateComponents())
        }
        return allComponents
    }()

    public func createOKEntity() -> OKEntity {
        // Logic to create and configure a new OKEntity instance
        let newOKEntity = OKEntity()
        newOKEntity.name = "\(self.type) \(self.name)"
        
        for construct in componentsConstructs {
            // Add components to the new OKEntity
            // This is simplified; you'll have to adapt it to fit OctopusKit's component system
            construct.instantiateComponents().forEach {
                print("Adding component to \(self.type) \(self.name): \($0)")
                newOKEntity.addComponent($0)
            }
        }
        return newOKEntity
    }
    public override func didInitialize() {
        // Extracting the `Components` constructs from the children
        componentsConstructs = children.compactMap { $0 as? Components }
        
        // Automatically register the entity for future use
        EntityFactory.shared.register(type: type, name: self.name, entity: self)
    }

    public func create() -> OKEntity {
        let newOKEntity = OKEntity()
        
        // Initialize components from the constructs and add them to the new OKEntity.
        let instantiatedComponents = componentsConstructs.flatMap { $0.instantiateComponents() }
        for component in instantiatedComponents {
            newOKEntity.addComponent(component)
        }
        
        // TODO: Any other OKEntity configuration logic goes here
        
        return newOKEntity
    }
    
    public static func create(type: EntityType, name: String? = "") -> OKEntity? {
        return create(type: AnyKey(type), name: name)
    }
    
    public static func create(type: AnyKey, name: String? = "") -> OKEntity? {
        return EntityFactory.shared.create(type: type, name: name)
    }
}

extension BaseConstruct {
    var entities: [Entity] {
        return children(ofType: Entity.self)
    }
}

