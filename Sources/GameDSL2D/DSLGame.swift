//
//  File.swift
//  
//
//  Created by P. Mark Anderson on 7/24/23.
//

/**
 USAGE:
 Game {
     Level { /* level configuration */ }
     Entity { /* entity configuration */ }
     System(MyGlobalSystem())
     // Any other DSLGameElement...
 }

 */

import Foundation

protocol DSLGameElement {
    func load(into game: DSLGame)
}

struct DSLGame {
    var elements: [DSLGameElement] = []
//    var levels: [DSLLevel] = []
//    var entities: [DSLEntity] = []
//    var globalSystems: [DSLSystem] = []

    init(@DSLGameBuilder _ content: () -> [DSLGameElement]) {
        let gameElements = content()
        for element in gameElements {
            addElement(element)
        }
    }
    
    mutating func addElement(_ element: DSLGameElement) {
        element.load(into: self)
    }

//    mutating func addLevel(_ level: DSLLevel) {
//        levels.append(level)
//    }
//
//    mutating func addEntity(_ entity: DSLEntity) {
//        entities.append(entity)
//    }
//
//    mutating func addSystem(_ system: DSLSystem) {
//        globalSystems.append(system)
//    }
}

@resultBuilder
struct DSLGameBuilder {
    static func buildBlock(_ components: DSLGameElement...) -> [DSLGameElement] {
        return components
    }
}
