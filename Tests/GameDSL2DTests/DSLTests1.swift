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
        let game = Game(name: "Alien Invasion") {
            Scene(key: .playing) {
                Entity(type: .player) {
                    Components {[
                        TestComponent()
                    ]}
                }
            }

            GameState(key: .playing)
        }

        XCTAssertNotNil(game)
    }
}

class TestScene1: OKScene { }
class TestScene2: OKScene { }

class TestGameData: GameData {
    @Published var testDataProperty: Int
    
    init(testDataProperty: Int = 10) {
        self.testDataProperty = testDataProperty
        super.init()
    }
}

class AnotherGameData: GameData {
    var someValue: String
    
    init(someValue: String) {
        self.someValue = someValue
        super.init()
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

class TestComponent: ComponentType {
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didAddToEntity() {
        EventManager.shared.postEvent(.playerScored, userInfo: ["score": 100])
    }
}

class TestComponent2: ComponentType {
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

let playScene = Scene(key: .playing) {
    Entity(type: .player, name: "Player") {
        TestComponent()
    }
    .onEvent(.playerScored) { construct, eventInfo in
        print("Player scored: \(eventInfo ?? [:])")
    }

    Entity(type: .obstacle, name: "Obstacle") {
        TestComponent()
    }
    //    .population(count: 4, layout: .linear)

    Scenario(name: "Combat") {
        Entity(type: .enemy, name: "Alien") {
            TestComponent()
        }
        //        .population(count: 55, layout: .grid)
    }
}
