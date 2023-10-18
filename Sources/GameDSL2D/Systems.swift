import GameplayKit

public class Systems: BaseConstruct {
    var componentTypes: [GKComponent.Type] = []
    
    public override func didInitialize() {
        componentTypes = children.compactMap { $0 as? GKComponent.Type }
    }
}
