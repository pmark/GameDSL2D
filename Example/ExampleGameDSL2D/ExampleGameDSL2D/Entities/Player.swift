//
//  Player.swift
//  
//
//  Created by P. Mark Anderson on 9/26/23.
//

import OctopusKit
import GameDSL2D

/*
 extension GameDSL2D.Entity {
 static var player: GameDSL2D.Entity {
 Entity(type: .player) {
 PhysicsComponent()
 }
 
 State(.spawning)
 .didEnter(from: .inactive) { state in
 // Logic for when transitioning from inactive to spawning.
 }
 
 State(.active)
 .didEnter(from: .spawning) { state in
 // Logic for when transitioning from spawning to active.
 }
 .willExit(to: .inactive) { state in
 // Logic for when transitioning from active to inactive.
 }
 .components([
 RelayComponent(for: scene.sharedPointerEventComponent),
 PointerControlledRotationComponent()
 ])
 
 // Global components for the player entity, independent of the state.
 Components {[
 NodeComponent(node: SKSpriteNode(color: .green, size: CGSize(widthAndHeight: 50))),
 UIViewModelComponent()
 ]}
 }
 }
 */
