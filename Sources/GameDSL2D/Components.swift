import GameplayKit

public typealias ComponentType = GKComponent

public class Components: BaseConstruct {
    
    let componentsClosure: () -> [ComponentType]

    public init(_ builder: @escaping () -> [ComponentType]) {
        self.componentsClosure = builder
    }

    func instantiateComponents() -> [ComponentType] {
        return componentsClosure()
    }
}
