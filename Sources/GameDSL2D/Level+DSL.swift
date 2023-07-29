import GameplayKit

public extension Level {
    convenience init(_ name: String? = nil, @LevelBuilder _ content: () -> [GameElement]) {
        self.init(name)
        let elements = content()
        
        elements.forEach { element in
            if let entity = element as? Entity {
                addEntity(entity)
            } else if let component = element as? Component {
                addComponent(component)
            } else if let scenario = element as? Scenario {
                addScenario(scenario)
            }
        }
    }
}
