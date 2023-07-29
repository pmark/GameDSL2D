import GameplayKit

public class Level: GameElement {
    public var name: String?
    public var entities: [Entity] = []
    public var components: [GKComponent] = []
    public var systems: [System] = []
    public var scenarios: [Scenario] = []
    
    public init(_ name: String? = nil) {
        self.name = name
    }
    
    public func addEntity(_ entity: Entity) {
        entities.append(entity)
    }
    
    public func removeEntity(_ entity: Entity) {
        entities.removeAll { $0 === entity }
    }
    
    public func addComponent(_ component: GKComponent) {
        components.append(component)
    }
    
    public func removeComponent(_ component: GKComponent) {
        components.removeAll { $0 === component }
    }
     
    public func addSystem(_ system: System) {
        systems.append(system)
    }
    
    public func removeSystem(_ system: System) {
        systems.removeAll { $0 === system }
    }
   
    public func addScenario(_ scenario: Scenario) {
        scenarios.append(scenario)
    }
    
    public func removeScenario(_ scenario: Scenario) {
        scenarios.removeAll { $0 === scenario }
    }
}