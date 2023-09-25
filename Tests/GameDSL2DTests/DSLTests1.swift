//
//  DSLTests1.swift
//  
//
//  Created by P. Mark Anderson on 8/27/23.
//

import XCTest
import OctopusKit
import SwiftUI
@testable import GameDSL2D

final class DSLTests1: XCTestCase {
    class func silencio() {
        OctopusKit.logForDebug.disabled = true
        OctopusKit.logForTips.disabled  = true
        OctopusKit.logForErrors.disabled = true
        OctopusKit.logForDeinits.disabled = true
        OctopusKit.logForStates.disabled = true
        OctopusKit.logForComponents.disabled = true
        OctopusKit.logForFramework.disabled = true
        OctopusKit.logForWarnings.disabled = true
        OctopusKit.logForResources.disabled = true
    }
    
    override class func setUp() {
        super.setUp()
        silencio()
    }
    
    func testBasicGame() {
        let _ = Game(name: "Alien Invasion") {
            
            let _ = Scene(sceneIdentifier: .playing) {
                // Entities, etc go here
            }
            
            GameState(.launch)
            GameState(.mainMenu)
            GameState(.playing)
            
            Components {[
                TestComponent()
            ]}
        }
    }
}

class TestScene1: OKScene { }
class TestScene2: OKScene { }

class TestGameData: GameData {
    @Published var testDataProperty: Int
    
    init(testDataProperty: Int = 10) {
        self.testDataProperty = testDataProperty
    }
}

class AnotherGameData: GameData {
    var someValue: String
    
    init(someValue: String) {
        self.someValue = someValue
    }
}

struct MainMenuView: View {
    var body: some View {
        Text("Main Menu")
    }
}

struct PausedView: View {
    var body: some View {
        Text("Paused")
    }
}

struct GameOverView: View {
    var body: some View {
        Text("Game Over")
    }
}

struct HUDView: View {
    var body: some View {
        Text("HUD")
    }
}

let playScene = Scene(sceneIdentifier: .playing) {
    Entity(name: "Player") {
        TestComponent()
    }
    
    Entity(name: "Obstacle") {
        TestComponent()
    }
//    .population(count: 4, layout: .linear)
    
    Scenario(name: "Combat") {
        Entity(name: "Alien") {
            TestComponent()
        }
//        .population(count: 55, layout: .grid)
    }
}
