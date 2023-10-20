//
//  Entity+State.swift
//  
//
//  Created by P. Mark Anderson on 10/18/23.
//

import Foundation

public extension Entity {
    
    func add(state: State) {
        states[state.key] = state
    }

    func remove(stateKey: AnyKey) {
        states.removeValue(forKey: stateKey)
    }
    
    func enterState(_ key: AnyKey) {
        guard let newState = states[key] else {
            print("Invalid state transition: State \(key) not found.")
            return
        }
        
        currentState?.triggerOnExit(to: key)
        currentState = newState
        newState.triggerOnEnter(from: currentState?.key)
    }

    func enterState(_ key: EntityStateKey) {
        self.enterState(AnyKey(key.stringValue))
    }

    func enterEnemyState(_ key: EnemyStateKey) {
        self.enterState(AnyKey(key.stringValue))
    }

    func enterFlyingState(_ key: FlyingStateKey) {
        self.enterState(AnyKey(key.stringValue))
    }

    func enterVehicleState(_ key: VehicleStateKey) {
        self.enterState(AnyKey(key.stringValue))
    }

    func enterPlayerState(_ key: PlayerStateKey) {
        self.enterState(AnyKey(key.stringValue))
    }

    func enterItemState(_ key: ItemStateKey) {
        self.enterState(AnyKey(key.stringValue))
    }

    func enterSceneState(_ key: SceneStateKey) {
        self.enterState(AnyKey(key.stringValue))
    }

    func enterEconomicState(_ key: EconomicStateKey) {
        self.enterState(AnyKey(key.stringValue))
    }

    func enterPuzzleState(_ key: PuzzleStateKey) {
        self.enterState(AnyKey(key.stringValue))
    }

    func enterStrategyState(_ key: StrategyStateKey) {
        self.enterState(AnyKey(key.stringValue))
    }

    func enterAnimationState(_ key: AnimationStateKey) {
        self.enterState(AnyKey(key.stringValue))
    }

    func enterMultiplayerState(_ key: MultiplayerStateKey) {
        self.enterState(AnyKey(key.stringValue))
    }

    func enterWeatherState(_ key: WeatherStateKey) {
        self.enterState(AnyKey(key.stringValue))
    }

    func enterNarrativeState(_ key: NarrativeStateKey) {
        self.enterState(AnyKey(key.stringValue))
    }
    
    func enterMotionState(_ key: MotionStateKey) {
        self.enterState(AnyKey(key.stringValue))
    }
    
    func enterConditionState(_ key: ConditionStateKey) {
        self.enterState(AnyKey(key.stringValue))
    }
    
    func enterProjectileState(_ key: ProjectileStateKey) {
        self.enterState(AnyKey(key.stringValue))
    }
    
    func enterSpecialState(_ key: SpecialStateKey) {
        self.enterState(AnyKey(key.stringValue))
    }
    
    func enterScenarioState(_ key: ScenarioStateKey) {
        self.enterState(AnyKey(key.stringValue))
    }
}
