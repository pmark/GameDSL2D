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

//extension KeyProtocol {
//    public static func ==(lhs: Self, rhs: Self) -> Bool {
//        return lhs.stringValue == rhs.stringValue
//    }
//}

extension String: KeyProtocol {
    public var stringValue: String { self }
}

public struct AnyKey: Hashable, Equatable {
    public let value: any KeyProtocol
    public var stringValue: String { value.stringValue }
    
    public init<T: KeyProtocol>(value: T) {
        self.value = value
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(value.stringValue)
    }
    
    public static func == (lhs: AnyKey, rhs: AnyKey) -> Bool {
        lhs.stringValue == rhs.stringValue
    }
    
    public init(value: any KeyProtocol) {
        self.value = value
    }
    
    public init(_ key: String) {
        self.init(value: key as any KeyProtocol)
    }
    
    public init(_ key: StateKey) {
        self.init(value: key as any KeyProtocol)
    }
    
    public init(_ key: GameStateKey) {
        self.init(value: key as any KeyProtocol)
    }
    
    public init(_ key: GameEventKey) {
        self.init(value: key as any KeyProtocol)
    }
    
    public init(_ key: SceneKey) {
        self.init(value: key as any KeyProtocol)
    }
    
    public init(_ key: EntityType) {
        self.init(value: key as any KeyProtocol)
    }
}

extension RawRepresentable where RawValue == String {
    public var stringValue: String {
        return self.rawValue
    }
}
