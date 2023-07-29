import GameplayKit

public protocol GameElement {
//    func buildElement()
}

public extension Game {
    convenience init(@GameBuilder _ content: () -> [GameElement]) {
        self.init()
        let elements = content()
        self.elements = elements
        
        elements.forEach { element in
            if let level = element as? Level {
                addLevel(level)
            } else if let component = element as? Component {
                addComponent(component)
            } else if let system = element as? System {
                addSystem(system)
            }
        }
    }
}
