//
//  EntityBuilder.swift
//  
//
//  Created by P. Mark Anderson on 7/29/23.
//

import GameplayKit

@resultBuilder
public struct EntityBuilder {
    public static func buildBlock(_ components: Component...) -> [Component] {
        return components
    }
    
    public static func buildBlock(_ components: [Component]) -> [Component] {
        return components
    }
    
    public static func buildIf(_ component: Component?) -> [Component] {
        return component.map { [$0] } ?? []
    }
    
    public static func buildEither(second components: [Component]) -> [Component] {
        return components
    }
}
