//
//  File.swift
//  
//
//  Created by P. Mark Anderson on 8/27/23.
//

import Combine
import OctopusKit

protocol Activatable {
    var isActive: Bool { get set }
    func activate()
}

public class BaseConstruct {
    var name: String?
    var data: GameData?
    var children: [Any] = []
    
    weak var parent: BaseConstruct? = nil {
        didSet {
            didSetParent()
        }
    }
    
    init(name: String? = nil, data: (() -> GameData)? = nil, children: [Any] = []) {
        self.name = name
        self.children = children
        
        if let gameData = data {
            self.data = gameData()
        }
        
        // Set parent for each child
        self.children.forEach {
            if let childConstruct = $0 as? BaseConstruct {
                childConstruct.parent = self
            }
        }
        didInitialize()
    }
    
    func didInitialize() {
        // Default implementation does nothing
    }
    
    convenience init(name: String, data: (() -> GameData)? = nil, @GameConstructBuilder children: () -> [Any]) {
        self.init(name: name, data: data, children: children())
    }
    
    convenience init(name: String) {
        self.init(name: name, data: nil)
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
    
    func children<T: BaseConstruct>(ofType type: T.Type) -> [T] {
        return children.compactMap { $0 as? T }
    }
    
    func getParentData<T: GameData>() -> T? {
        return parent?.data as? T
    }
    
    func getAncestorData<T: GameData>(ofType type: T.Type) -> T? {
        var currentParent = parent
        while let parent = currentParent {
            if let data = parent.data as? T {
                return data
            }
            currentParent = parent.parent
        }
        return nil
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
