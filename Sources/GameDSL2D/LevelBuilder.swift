import GameplayKit

@resultBuilder
public struct LevelBuilder {
    public static func buildBlock(_ elements: GameElement...) -> [GameElement] {
        return elements
    }
    
    public static func buildBlock(_ entities: Entity...) -> [Entity] {
        return entities
    }
    
    public static func buildBlock(_ components: GKComponent...) -> [GKComponent] {
        return components
    }
    
    public static func buildBlock(_ systems: System...) -> [System] {
        return systems
    }
    
    public static func buildBlock(_ entities: [Entity]) -> [Entity] {
        return entities
    }
    
    public static func buildBlock(_ components: [GKComponent]) -> [GKComponent] {
        return components
    }
    
    public static func buildBlock(_ systems: [System]) -> [System] {
        return systems
    }
    
    public static func buildIf(_ entity: Entity?) -> [Entity] {
        return entity.map { [$0] } ?? []
    }
    
    public static func buildIf(_ component: GKComponent?) -> [GKComponent] {
        return component.map { [$0] } ?? []
    }
    
    public static func buildIf(_ system: System?) -> [System] {
        return system.map { [$0] } ?? []
    }
    
    public static func buildEither(first entities: [Entity]) -> [Entity] {
        return entities
    }
    
    public static func buildEither(second components: [GKComponent]) -> [GKComponent] {
        return components
    }
    
    public static func buildEither(second systems: [System]) -> [System] {
        return systems
    }
}
