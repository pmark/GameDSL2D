//
//  File.swift
//  
//
//  Created by P. Mark Anderson on 10/19/23.
//

import Foundation

public extension State {
    convenience init(key: String) {
        self.init(key: AnyKey(key))
    }
    
    convenience init(key: EntityStateKey) {
        self.init(key: AnyKey(key.stringValue))
    }

    convenience init(key: EnemyStateKey) {
        self.init(key: AnyKey(key.stringValue))
    }

    convenience init(key: FlyingStateKey) {
        self.init(key: AnyKey(key.stringValue))
    }

    convenience init(key: VehicleStateKey) {
        self.init(key: AnyKey(key.stringValue))
    }

    convenience init(key: PlayerStateKey) {
        self.init(key: AnyKey(key.stringValue))
    }

    convenience init(key: ItemStateKey) {
        self.init(key: AnyKey(key.stringValue))
    }

    convenience init(key: SceneStateKey) {
        self.init(key: AnyKey(key.stringValue))
    }

    convenience init(key: EconomicStateKey) {
        self.init(key: AnyKey(key.stringValue))
    }

    convenience init(key: PuzzleStateKey) {
        self.init(key: AnyKey(key.stringValue))
    }

    convenience init(key: StrategyStateKey) {
        self.init(key: AnyKey(key.stringValue))
    }

    convenience init(key: AnimationStateKey) {
        self.init(key: AnyKey(key.stringValue))
    }

    convenience init(key: MultiplayerStateKey) {
        self.init(key: AnyKey(key.stringValue))
    }

    convenience init(key: WeatherStateKey) {
        self.init(key: AnyKey(key.stringValue))
    }

    convenience init(key: NarrativeStateKey) {
        self.init(key: AnyKey(key.stringValue))
    }

    convenience init(key: MotionStateKey) {
        self.init(key: AnyKey(key.stringValue))
    }

    convenience init(key: ConditionStateKey) {
        self.init(key: AnyKey(key.stringValue))
    }

    convenience init(key: ProjectileStateKey) {
        self.init(key: AnyKey(key.stringValue))
    }

    convenience init(key: SpecialStateKey) {
        self.init(key: AnyKey(key.stringValue))
    }

    convenience init(key: ScenarioStateKey) {
        self.init(key: AnyKey(key.stringValue))
    }
}
