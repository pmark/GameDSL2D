//
//  AnyKey.swift
//  
//
//  Created by P. Mark Anderson on 10/2/23.
//

import Foundation

public protocol KeyProtocol: Equatable {
    var stringValue: String { get }
}

extension KeyProtocol {
    public static func ==(lhs: Self, rhs: Self) -> Bool {
        return lhs.stringValue == rhs.stringValue
    }
}

public struct AnyKey: Hashable {
    public let value: any KeyProtocol
    
    public var stringValue: String { value.stringValue }
    
    public init(value: any KeyProtocol) {
        self.value = value
    }
    
    public static func ==(lhs: AnyKey, rhs: AnyKey) -> Bool {
        return lhs.value.stringValue == rhs.value.stringValue
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(value.stringValue)
    }
    
    init(_ key: StateKey) {
        self.init(value: key as any KeyProtocol)
    }
    
    init(_ key: GameStateKey) {
        self.init(value: key as any KeyProtocol)
    }
    
    init(_ key: GameEventKey) {
        self.init(value: key as any KeyProtocol)
    }
    
    init(_ key: SceneKey) {
        self.init(value: key as any KeyProtocol)
    }
    
    init(_ key: EntityType) {
        self.init(value: key as any KeyProtocol)
    }
}

extension RawRepresentable where RawValue == String {
    public var stringValue: String {
        return self.rawValue
    }
}
