//
//  EntityStateKey.swift
//  
//
//  Created by P. Mark Anderson on 10/19/23.
//

/**
 How to extend entity state keys:
 
 public enum MyCustomStateKey: String, KeyProtocol {
     case yourState1
     case yourState2
     // more states...
 }
 
 extension Entity {
     public func enterMyCustomState(_ key: MyCustomStateKey) {
         self.enterState(AnyKey(key.stringValue))
     }
 }
 */

import Foundation

public enum EntityStateKey: String, KeyProtocol  {
    case active
    case completed
    case failed
    case destroyed
    case idle
    case locked
    case unlocked
    case hidden
    case visible
    case inProgress
    case paused
    case uninitiated
    case initiated
}

public enum EnemyStateKey: String, KeyProtocol  {
    case attacking
    case defending
    case retreating
    case charging
    case stunned
    case invincible
    case healing
    case patrolling
    case chasing
    case evasive
    case alert
    case investigating
    case summoning
}

public enum FlyingStateKey: String, KeyProtocol  {
    case hovering
    case ascending
    case descending
    case gliding
    case diving
    case stalling
    case accelerating
    case decelerating
}

public enum VehicleStateKey: String, KeyProtocol  {
    case accelerating
    case braking
    case cruising
    case drifting
    case offroad
    case reversing
    case parking
}

public enum PlayerStateKey: String, KeyProtocol  {
    case alive
    case dead
    case respawnable
    case respawning
    case spectating
    case disconnected
}

public enum ItemStateKey: String, KeyProtocol  {
    case available
    case activated
    case depleted
    case recharging
    case cooldown
    case hidden
    case discovered
    case locked
    case consumed
}

public enum SceneStateKey: String, KeyProtocol  {
    case loading
    case intro
    case gameplay
    case paused
    case summary
    case outro
    case unloading
}

public enum EconomicStateKey: String, KeyProtocol  {
    case selling
    case buying
    case outOfStock
    case replenishing
    case closed
}

public enum PuzzleStateKey: String, KeyProtocol  {
    case unassembled
    case assembling
    case assembled
    case misaligned
    case locked
    case unlocked
}

public enum StrategyStateKey: String, KeyProtocol  {
    case exploring
    case gatheringResources
    case building
    case trainingUnits
    case researching
    case scouting
    case negotiating
    case besieging
    case diplomatic
}

public enum AnimationStateKey: String, KeyProtocol  {
    case idle
    case playing
    case paused
    case completed
    case looping
    case reversing
}

public enum MultiplayerStateKey: String, KeyProtocol  {
    case waitingForPlayers
    case matchmaking
    case inLobby
    case inGame
    case postGame
}

public enum WeatherStateKey: String, KeyProtocol  {
    case clear
    case cloudy
    case rainy
    case stormy
    case snowy
    case foggy
}

public enum NarrativeStateKey: String, KeyProtocol  {
    case inactive
    case dialog
    case monologue
    case choicePoint
    case flashback
    case summary
}

public enum MotionStateKey: String, KeyProtocol  {
    case idle
    case walking
    case running
    case jumping
    case falling
    case disabled
    case crouching
    case climbing
    case swimming
    case taunting
    case emoting
}

public enum ConditionStateKey: String, KeyProtocol  {
    case frozen
    case confused
    case poisoned
    case onFire
    case victory
    case defeat
}

public enum ProjectileStateKey: String, KeyProtocol  {
    case fired
    case traveling
    case exploding
    case expired
    case ricocheting
    case splitting
    case homing
}

public enum SpecialStateKey: String, KeyProtocol  {
    case burrowed
    case petrified
    case charmed
    case shielded
    case phased
    case levitating
    case timeWarped
    case reviving
    case morphing
    case teleporting
    case dizzy
    case miniaturized
    case enlarged
    case invertedControls
    case indestructible
}

public enum ScenarioStateKey: String, KeyProtocol {
    case setup
    case start
    case inProgress
    case end
    case introduction
    case solved
    case failed
    case dialogue
    case exploring
    case foundSecret
    case countdown
    case resources
    case challenge
    case preEnding
    case ending
    case postEnding
    case pause
    case resume
    case reset
}
