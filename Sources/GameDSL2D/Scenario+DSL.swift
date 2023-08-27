import GameplayKit

public extension Scenario {
    convenience init(_ name: String? = nil, @ScenarioBuilder _ content: () -> [GameElement]) {
        self.init(name)
        let elements = content()
        
        elements.forEach { element in
            if let entity = element as? Entity {
                addEntity(entity)
                for component in entity.components {
                    // TODO: Figure out if scenario's level already has a system for this component type
                    addSystem(System(componentClass: type(of: component)))
                }
            }
        }
    }
}
