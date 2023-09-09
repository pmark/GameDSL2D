import OctopusKit

class Systems: BaseConstruct {
    var componentTypes: [OKComponent.Type]
    
    init(@GameConstructBuilder _ builder: () -> [OKComponent.Type]) {
        self.componentTypes = builder()
    }
}

/*

class Systems: BaseConstruct {
    private var componentTypes: [OKComponent.Type]

    init(@ComponentSystemBuilder builder: () -> [OKComponent.Type]) {
        self.componentTypes = builder()
        super.init(children: [])
    }
    
    func getComponents() -> [OKComponent.Type] {
        return componentTypes
    }
}

@resultBuilder
struct ComponentSystemBuilder {
    static func buildBlock(_ types: OKComponent.Type...) -> [OKComponent.Type] {
        return types
    }
}
*/
