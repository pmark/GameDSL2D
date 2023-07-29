import GameplayKit

public extension Scenario {
    convenience init(_ name: String? = nil, @ScenarioBuilder _ content: () -> [GameElement]) {
        self.init(name)
        let elements = content()
        
        elements.forEach { element in
            if let entity = element as? Entity {
                addEntity(entity)
            }
        }
    }
}
