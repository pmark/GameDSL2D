//
//  EntityType.swift
//  
//
//  Created by P. Mark Anderson on 9/28/23.
//

import Foundation

public enum EntityType: String, KeyProtocol {
    // Classic Arcade
    case player
    case enemy
    case boss
    case powerUp
    case projectile
    case obstacle
    case platform
    case collectible
    case coin
    case token
    case door
    case key
    case treasure
    case trap
    case npc

    // Modern Mobile & Hypercasual
    case runner
    case spinner
    case slider
    case jumper
    case swapper
    case shooter
    case blocker
    case mover
    case chaser
    case avoider
    case collector
    case dropper
    case thrower
    case booster
    case splitter
    case combiner
    case rotator

    // Vehicles
    case car
    case truck
    case airplane
    case helicopter
    case boat
    case submarine
    case spaceship
    case tank

    // Animals
    case bird
    case fish
    case dog
    case cat
    case dragon
    case dinosaur

    // Environmental
    case tree
    case rock
    case water
    case fire
    case cloud
    case wind
    case lightning

    // UI Elements
    case button
    case label
    case panel
    case progressBar

    // Other
    case camera
    case other
}
