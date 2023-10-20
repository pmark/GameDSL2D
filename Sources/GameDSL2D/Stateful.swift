//
//  Stateful.swift
//  
//
//  Created by P. Mark Anderson on 10/19/23.
//

import Foundation

public protocol Stateful {
    var states: [AnyKey: State] { get set }
    var currentState: State? { get set }
    
    @discardableResult func setStateOn(event: Notification.Name, to state: AnyKey) -> Self
    @discardableResult func setStateOn(event: String, to state: AnyKey) -> Self
}

public extension Stateful {
    @discardableResult
    func setStateOn(event: Notification.Name, to state: AnyKey) -> Self {
        return self.setStateOn(event: event.rawValue, to: state)
    }
    
    @discardableResult
    func setStateOn(event: String, to state: AnyKey) -> Self {
        if let baseConstruct = self as? BaseConstruct {
            baseConstruct.onEvent(event, perform: { construct, _ in
                if var statefulConstruct = construct as? Stateful {
                    statefulConstruct.enterState(state)
                }
            })
        }
        
        return self
    }

    mutating func add(state: State) {
        self.states[state.key] = state
    }

    mutating func remove(stateKey: AnyKey) {
        states.removeValue(forKey: stateKey)
    }
    
    mutating func enterState(_ key: AnyKey) {
        guard let newState = states[key] else {
            print("Invalid state transition: State \(key) not found.")
            return
        }
        
        currentState?.triggerOnExit(to: key)
        currentState = newState
        newState.triggerOnEnter(from: currentState?.key)
    }

    mutating func enterState(_ key: EntityStateKey) {
        self.enterState(AnyKey(key.stringValue))
    }

    mutating func enterEnemyState(_ key: EnemyStateKey) {
        self.enterState(AnyKey(key.stringValue))
    }

    mutating func enterFlyingState(_ key: FlyingStateKey) {
        self.enterState(AnyKey(key.stringValue))
    }

    mutating func enterVehicleState(_ key: VehicleStateKey) {
        self.enterState(AnyKey(key.stringValue))
    }

    mutating func enterPlayerState(_ key: PlayerStateKey) {
        self.enterState(AnyKey(key.stringValue))
    }

    mutating func enterItemState(_ key: ItemStateKey) {
        self.enterState(AnyKey(key.stringValue))
    }

    mutating func enterSceneState(_ key: SceneStateKey) {
        self.enterState(AnyKey(key.stringValue))
    }

    mutating func enterEconomicState(_ key: EconomicStateKey) {
        self.enterState(AnyKey(key.stringValue))
    }

    mutating func enterPuzzleState(_ key: PuzzleStateKey) {
        self.enterState(AnyKey(key.stringValue))
    }

    mutating func enterStrategyState(_ key: StrategyStateKey) {
        self.enterState(AnyKey(key.stringValue))
    }

    mutating func enterAnimationState(_ key: AnimationStateKey) {
        self.enterState(AnyKey(key.stringValue))
    }

    mutating func enterMultiplayerState(_ key: MultiplayerStateKey) {
        self.enterState(AnyKey(key.stringValue))
    }

    mutating func enterWeatherState(_ key: WeatherStateKey) {
        self.enterState(AnyKey(key.stringValue))
    }

    mutating func enterNarrativeState(_ key: NarrativeStateKey) {
        self.enterState(AnyKey(key.stringValue))
    }
    
    mutating func enterMotionState(_ key: MotionStateKey) {
        self.enterState(AnyKey(key.stringValue))
    }
    
    mutating func enterConditionState(_ key: ConditionStateKey) {
        self.enterState(AnyKey(key.stringValue))
    }
    
    mutating func enterProjectileState(_ key: ProjectileStateKey) {
        self.enterState(AnyKey(key.stringValue))
    }
    
    mutating func enterSpecialState(_ key: SpecialStateKey) {
        self.enterState(AnyKey(key.stringValue))
    }
    
    mutating func enterScenarioState(_ key: ScenarioStateKey) {
        self.enterState(AnyKey(key.stringValue))
    }
}
