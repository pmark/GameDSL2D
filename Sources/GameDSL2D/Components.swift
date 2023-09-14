import OctopusKit

typealias ComponentType = OKComponent

class Components: BaseConstruct {
    
    let componentClosures: () -> [ComponentType]

    init(_ builder: @escaping () -> [ComponentType]) {
        self.componentClosures = builder
    }

    func instantiateComponents() -> [ComponentType] {
        return componentClosures()
    }
}
