import GameplayKit
import OctopusKit
import Foundation

class Entity: BaseConstruct, Activatable {
    var isActive: Bool = false
    
    lazy public var okEntity: OKEntity = {
        return OKEntity()
    }()
    
    public var componentConstructs: [Components] = []
    
    private(set) lazy var components: [OKComponent] = {
        var allComponents: [OKComponent] = []
        for construct in componentConstructs {
            allComponents.append(contentsOf: construct.instantiateComponents())
        }
        return allComponents
    }()
    
    override func didSetParent() {
        // Extracting the `Components` constructs from the children
        componentConstructs = children.compactMap { $0 as? Components }
    }
}

extension BaseConstruct {
    var entities: [Entity] {
        return children(ofType: Entity.self)
    }
}

/*
class Entity: BaseConstruct {
    var componentConstructs: Components?
    
    lazy var components: [OKComponent] = {
        print("Entity getting components...")
        if let componentConstructs = self.componentConstructs {
        print("\nGot 'em")
            return componentConstructs.instantiateComponents()
        }
        print("\nNONE")
        return []
    }()

    override func didInitialize() {
        super.didInitialize()
        
        // Assign the componentConstructs if they are among the children
        self.componentConstructs = self.children.compactMap { $0 as? Components }.first
    }
}
*/



/*
extension Entity {

    var components: [GKComponent] {
        okEntity.components
    }
    
    public func addComponent(_ component: Component) {
        okEntity.addComponent(component)
    }
    
    public func removeComponent(_ component: Component) {
        okEntity.removeComponent(ofType: type(of: component))
    }
    
    func component<ComponentType>(ofType componentClass: ComponentType.Type) -> ComponentType? where ComponentType : OKComponent {
        print("E: getting \(ComponentType.self)")
        return okEntity.component(ofType: ComponentType.self)
    }
}
*/
