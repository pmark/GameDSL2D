//
//  DSLGameViewTests.swift
//  
//
//  Created by P. Mark Anderson on 9/26/23.
//

import XCTest
@testable import GameDSL2D

final class DSLGameViewTests: XCTestCase {
    
    let testGame = Game(name: "Test Game") {
        Scene(.playing) {
            Entity(name: "TestEntity") {
                Components {[
                    TestComponent()
                ]}
            }
        }
        GameState(.playing)
    }

    func testGameInitialization() {
        let view = DSLGameView(testGame)
        XCTAssertNotNil(view.game)
        XCTAssertEqual(view.game.name, "Test Game")
        
        let scene = testGame.scenes.first(where: { $0.name == "playing scene" })
        XCTAssertNotNil(scene)
        
        let entity = scene?.entities.first(where: { $0.name == "TestEntity" })
        XCTAssertNotNil(entity)
        
        let component = entity?.components.first(where: { $0 is TestComponent })
        XCTAssertNotNil(component)
    }
}
