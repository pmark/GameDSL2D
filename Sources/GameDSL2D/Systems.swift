import OctopusKit

public class Systems: BaseConstruct {
    var componentTypes: [OKComponent.Type] = []
    
//    init(@GameConstructBuilder _ builder: () -> [OKComponent.Type]) {
//        self.componentTypes = builder()
//        super.init(name: "", children: builder())
//    }
    
    public override func didInitialize() {
        componentTypes = children.compactMap { $0 as? OKComponent.Type }
    }
}
