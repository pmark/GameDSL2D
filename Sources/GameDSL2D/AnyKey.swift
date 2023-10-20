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
    
}

extension RawRepresentable where RawValue == String {
    public var stringValue: String {
        return self.rawValue
    }
}

public extension AnyKey {
    init(_ key: String) {
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
    
    init(_ key: EntityStateKey) {
        self.init(value: key as any KeyProtocol)
    }
    
    init(_ key: EnemyStateKey) {
        self.init(value: key as any KeyProtocol)
    }
    
    init(_ key: FlyingStateKey) {
        self.init(value: key as any KeyProtocol)
    }
    
    init(_ key: VehicleStateKey) {
        self.init(value: key as any KeyProtocol)
    }
    
    init(_ key: PlayerStateKey) {
        self.init(value: key as any KeyProtocol)
    }
    
    init(_ key: ItemStateKey) {
        self.init(value: key as any KeyProtocol)
    }
    
    init(_ key: SceneStateKey) {
        self.init(value: key as any KeyProtocol)
    }
    
    init(_ key: EconomicStateKey) {
        self.init(value: key as any KeyProtocol)
    }
    
    init(_ key: PuzzleStateKey) {
        self.init(value: key as any KeyProtocol)
    }
    
    init(_ key: StrategyStateKey) {
        self.init(value: key as any KeyProtocol)
    }
    
    init(_ key: AnimationStateKey) {
        self.init(value: key as any KeyProtocol)
    }
    
    init(_ key: MultiplayerStateKey) {
        self.init(value: key as any KeyProtocol)
    }
    
    init(_ key: WeatherStateKey) {
        self.init(value: key as any KeyProtocol)
    }
    
    init(_ key: NarrativeStateKey) {
        self.init(value: key as any KeyProtocol)
    }
    
    init(_ key: MotionStateKey) {
        self.init(value: key as any KeyProtocol)
    }
    
    init(_ key: ConditionStateKey) {
        self.init(value: key as any KeyProtocol)
    }
    
    init(_ key: ProjectileStateKey) {
        self.init(value: key as any KeyProtocol)
    }
    
    init(_ key: SpecialStateKey) {
        self.init(value: key as any KeyProtocol)
    }
    
    init(_ key: ScenarioStateKey) {
        self.init(value: key as any KeyProtocol)
    }
}

