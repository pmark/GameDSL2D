import GameplayKit

public typealias ComponentType = GKComponent

public class Components: BaseConstruct {
    
    let componentClosures: () -> [ComponentType]

    public init(_ builder: @escaping () -> [ComponentType]) {
        self.componentClosures = builder
    }

    func instantiateComponents() -> [ComponentType] {
        return componentClosures()
    }
}
