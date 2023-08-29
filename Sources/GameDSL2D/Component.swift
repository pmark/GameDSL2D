import OctopusKit
import GameplayKit

class Components: BaseConstruct {
    let componentClosures: () -> [OKComponent]

    init(_ builder: @escaping () -> [OKComponent]) {
        self.componentClosures = builder
    }

    func instantiateComponents() -> [OKComponent] {
        return componentClosures()
    }
}

/*
class Component: BaseConstruct {
    enum ComponentType {
        case ok(OKComponent)
        case gk(GKComponent)
    }

    let componentType: ComponentType

    init(_ component: OKComponent) {
        self.componentType = .ok(component)
    }

    init(_ component: GKComponent) {
        self.componentType = .gk(component)
    }
    
    func getInstance() -> OKComponent {
        switch componentType {
        case .ok(let okComponent):
            return okComponent
        case .gk(let gkComponent):
            // Here, wrap your GKComponent into a compatible OKComponent.
            // You'd need to define how this conversion should work, potentially using a wrapper class.
            return OKComponentWrapper(gkComponent)
        }
    }
}


class Components {
    let componentClosures: [() -> Component]
    
    init(@ComponentsBuilder _ builder: () -> [() -> Component]) {
        self.componentClosures = builder()
    }
    
    func instantiateComponents() -> [Component] {
        return componentClosures.map { $0() }
    }
}


@resultBuilder
struct ComponentsBuilder {
    static func buildBlock(_ components: () -> Component...) -> [() -> Component] {
        return components
    }
}
 */


class OKComponentWrapper: OKComponent {
    
    private let gkComponent: GKComponent
    
    init(_ gkComponent: GKComponent) {
        print("\n\nwrapping GKComponent")
        self.gkComponent = gkComponent
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Example of a method to demonstrate how wrapping could work:
    override func update(deltaTime seconds: TimeInterval) {
        // Redirect to GKComponent's update functionality, if necessary
        gkComponent.update(deltaTime: seconds)
    }
    
    // Add any other necessary methods and properties to ensure compatibility
    // between GKComponent and OKComponent.
    
}
