import GameplayKit

public class Entity: GameElement {
    public let name: String?
    public let gkEntity: GKEntity
    public var elements: [GameElement] = []

    public init(_ name: String? = nil) {
        self.name = name
        gkEntity = GKEntity()
    }
    
    var components: [GKComponent] {
        gkEntity.components
    }
    
    public func addComponent(_ component: Component) {
//        components.append(component)
        gkEntity.addComponent(component)
    }
    
    public func removeComponent(_ component: Component) {
//        components.removeAll { $0 === component }
        gkEntity.removeComponent(ofType: type(of: component))
    }
    
    func component<ComponentType>(ofType componentClass: ComponentType.Type) -> ComponentType? where ComponentType : GKComponent {
        print("E: getting \(ComponentType.self)")
        return gkEntity.component(ofType: ComponentType.self)
    }
}
