import GameplayKit

public class Game {
    public var levels: [Level] = []
    public var components: [GKComponent] = []
    public var systems: [System] = []
    public var elements: [GameElement] = []
    
    public init() {}
     
    public func addElement(_ element: GameElement) {
        elements.append(element)
    }
    
    public func addLevel(_ level: Level) {
        levels.append(level)
    }
    
    public func removeLevel(_ level: Level) {
        levels.removeAll { $0 === level }
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
}
