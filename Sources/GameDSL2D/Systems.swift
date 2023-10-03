import GameplayKit

public class Systems: BaseConstruct {
    var componentTypes: [GKComponent.Type] = []
    
//    init(@GameConstructBuilder _ builder: () -> [GKComponent.Type]) {
//        self.componentTypes = builder()
//        super.init(name: "", children: builder())
//    }
    
    public override func didInitialize() {
        componentTypes = children.compactMap { $0 as? GKComponent.Type }
    }
}
