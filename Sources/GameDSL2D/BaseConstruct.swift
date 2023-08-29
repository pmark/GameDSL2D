//
//  File.swift
//  
//
//  Created by P. Mark Anderson on 8/27/23.
//

import Combine
import OctopusKit

protocol Activatable {
    func activate()
}

class BaseConstruct {
    var name: String?
    var data: GameData?
    var children: [Any] = []
    weak var parent: BaseConstruct? = nil {
        didSet {
            didSetParent()
        }
    }
    
    init(name: String? = nil, data: GameData? = nil, children: [Any] = []) {
        self.name = name
        self.data = data ?? children.lazy.compactMap { ($0 as? LazyData)?.data }.first
        self.children = children
        
        // Set parent for each child
        self.children.forEach {
            if let childConstruct = $0 as? BaseConstruct {
                childConstruct.parent = self
            }
        }
    }

    convenience init(_ name: String, @GameConstructBuilder children: () -> [Any]) {
        self.init(name: name, children: children())
    }
    
    convenience init(_ name: String) {
        self.init(name: name, children: [])
    }
    
    // Activate function remains unchanged
    func activate() {
        if let triggerData = data {
            triggerData.triggers.forEach { $0.evaluate(using: triggerData) }
        }

        // This assumes that some child constructs can be "activated" and, if so, activates them
        children.compactMap { $0 as? Activatable }.forEach { $0.activate() }
    }
    
    func didSetParent() {
    }
}

@resultBuilder
struct GameConstructBuilder {

    // Single construct
    static func buildBlock(_ component: Any...) -> [Any] {
        return component
    }
    
    // For conditional constructs
    static func buildIf(_ component: Any?) -> [Any] {
        return component.map { [$0] } ?? []
    }
    
    static func buildEither(first component: Any) -> [Any] {
        return [component]
    }
    
    static func buildEither(second component: Any) -> [Any] {
        return [component]
    }
}


// MARK: - GameConstructs

final class Game: BaseConstruct {
//    convenience init(_ name: String, @GameConstructBuilder children: () -> [Any]) {
//        self.init(name, children: children())
//    }
}

final class Level: BaseConstruct {
//    convenience init(_ name: String, @GameConstructBuilder children: () -> [Any]) {
//        self.init(name, children: children())
//    }
}

final class Scenario: BaseConstruct {
//    convenience init(_ name: String, @GameConstructBuilder children: () -> [Any]) {
//        self.init(name: name, children: children())
//    }
//
//    convenience init(_ name: String) {
//        self.init(name: name, children: [])
//    }
}

final class Entity: BaseConstruct {
    lazy public var okEntity: OKEntity = {
        return OKEntity()
    }()
    
//    convenience init(_ name: String, @GameConstructBuilder children: () -> [Any]) {
//        self.init(name: name, children: children())
//    }
}

final class LazyData: BaseConstruct {
    // In the initializer, we don't want to directly take the GameData instance.
    // Instead, we want to take a closure that creates and returns the GameData.
    init(_ dataProducer: @escaping () -> GameData) {
        super.init(data: dataProducer())
    }
}
