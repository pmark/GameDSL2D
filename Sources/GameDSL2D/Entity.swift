import GameplayKit
import OctopusKit

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
