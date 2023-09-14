import OctopusKit

class Systems: BaseConstruct {
    var componentTypes: [OKComponent.Type]
    
    // TODO: get your own damn components
    
    init(@GameConstructBuilder _ builder: () -> [OKComponent.Type]) {
        self.componentTypes = builder()
    }
}
