//
//  BaseConstruct.swift
//  

import Foundation
import OctopusKit

protocol Activatable {
    var isActive: Bool { get set }
    func activate()
    func deactivate()
}

public class BaseConstruct {
    var name: String
    var data: GameData?
    var children: [Any]
    var isActive: Bool = false
    var onActivateClosure: ((BaseConstruct) -> Void)?
    var onDeactivateClosure: ((BaseConstruct) -> Void)?
    var eventTokens: [String: NSObjectProtocol] = [:]
    
    weak var parent: BaseConstruct? = nil {
        didSet {
            didSetParent()
        }
    }
    
    public init(name: String? = nil, data: (() -> GameData)? = nil, children: [Any] = []) {
        self.name = name ?? ""
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
     
    public convenience init(name: String = "", data: (() -> GameData)? = nil, @GameConstructBuilder childConstructs: () -> [Any]) {
        self.init(name: name, data: data, children: childConstructs())
    }
    
    deinit {
        for token in eventTokens.values {
            NotificationCenter.default.removeObserver(token)
        }
    }
    
    public func evaluateTriggers() {
        if let triggerData = data {
            triggerData.triggers.forEach { $0.evaluate(using: triggerData) }
        }
    }
    
    @discardableResult
    public func onActivate(_ closure: @escaping (BaseConstruct) -> Void) -> Self {
        self.onActivateClosure = closure
        return self
    }

    @discardableResult
    public func onDeactivate(_ closure: @escaping (BaseConstruct) -> Void) -> Self {
        self.onDeactivateClosure = closure
        return self
    }

    public func onActivate() {
        self.onActivateClosure?(self)
    }
    
    public func onDeactivate() {
        self.onDeactivateClosure?(self)
    }
    
    public func activate() {
        // This assumes that some child constructs can be "activated" and, if so, activates them
        isActive = true
        print("--BC activate \(self.name)")
        children.compactMap { $0 as? Activatable }.forEach { $0.activate() }
        onActivate()
    }
    
    public func deactivate() {
        isActive = false
        children.compactMap { $0 as? Activatable }.forEach { $0.deactivate() }
        onDeactivate()
    }
    
    public func didSetParent() { }
    
    public func didInitialize() { }

    public func children<T>(ofType type: T.Type) -> [T] {
        return children.compactMap { $0 as? T }
    }
    
    public func getParentData<T: GameData>() -> T? {
        return parent?.data as? T
    }
    
    public func getAncestorData<T: GameData>(ofType type: T.Type) -> T? {
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
public struct GameConstructBuilder {

    // Single construct
    public static func buildBlock(_ construct: Any...) -> [Any] {
        return construct
    }
    
    // For conditional constructs
    public static func buildIf(_ construct: Any?) -> [Any] {
        return construct.map { [$0] } ?? []
    }
    
    public static func buildEither(first construct: Any) -> [Any] {
        return [construct]
    }
    
    public static func buildEither(second construct: Any) -> [Any] {
        return [construct]
    }
}
