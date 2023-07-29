import GameplayKit

@resultBuilder
public struct GameBuilder {
    public static func buildBlock(_ elements: GameElement...) -> [GameElement] {
        return elements
    }
    
    public static func buildBlock(_ levels: Level...) -> [Level] {
        return levels
    }
    
    public static func buildBlock(_ levels: [Level]) -> [Level] {
        return levels
    }
    
    public static func buildBlock(_ components: GKComponent...) -> [GKComponent] {
        return components
    }
    
    public static func buildBlock(_ systems: System...) -> [System] {
        return systems
    }
    
    public static func buildBlock(_ components: [GKComponent]) -> [GKComponent] {
        return components
    }
    
    public static func buildBlock(_ systems: [System]) -> [System] {
        return systems
    }
    
    public static func buildIf(_ component: GKComponent?) -> [GKComponent] {
        return component.map { [$0] } ?? []
    }
    
    public static func buildIf(_ system: System?) -> [System] {
        return system.map { [$0] } ?? []
    }
    
    public static func buildEither(first components: [GKComponent]) -> [GKComponent] {
        return components
    }
    
    public static func buildEither(second systems: [System]) -> [System] {
        return systems
    }
}
