//
//  Game.swift
//  
//
//  Created by P. Mark Anderson on 7/24/23.
//

import XCTest
@testable import GameDSL2D

final class CoreTests: XCTestCase {
    
    // Test for game initialization with one level
    func testSingleLevelInitialization() {
        let game = Game {
            Level("Test Level")
        }
        XCTAssertEqual(game.elements.count, 1, "Game should contain one element after initialization")
        XCTAssertEqual(game.levels.count, 1, "Game should contain one level after initialization")
        XCTAssert(game.elements.first is Level, "The first element should be a level")
    }
    
    // Test for game initialization with multiple levels
    func testMultiLevelInitialization() {
        let game = Game {
            Level("Test Level 1")
            Level("Test Level 2")
            Level("Test Level 3")
        }
        XCTAssertEqual(game.elements.count, 3, "Game should contain three levels after initialization")
    }
    
    // Test for game initialization with one level and one scenario
    func testLevelWithSingleScenarioInitialization() {
        let game = Game {
            Level("Test Level") {
                Scenario("Test Scenario")
            }
        }
        XCTAssertEqual(game.elements.count, 1, "Game should contain one level after initialization")
        let level = game.elements.first as? Level
        XCTAssertNotNil(level, "The first element should be a level")
        XCTAssertEqual(level?.scenarios.count, 1, "Level should contain one scenario after initialization")
    }
    
    // Test for game initialization with one level and multiple scenarios
    func testLevelWithMultiScenarioInitialization() {
        let game = Game {
            Level("Test Level") {
                Scenario("Test Scenario 1")
                Scenario("Test Scenario 2")
            }
        }
        XCTAssertEqual(game.elements.count, 1, "Game should contain one level after initialization")
        let level = game.elements.first as? Level
        XCTAssertNotNil(level, "The first element should be a level")
        XCTAssertEqual(level?.scenarios.count, 2, "Level should contain two scenarios after initialization")
    }
    
    // Test for game initialization with entities
    func testLevelWithEntitiesInitialization() {
        let game = Game {
            Level("Test Level") {
                Scenario("Test Scenario") {
                    Entity("Test Entity 1")
                    Entity("Entity with component") {
                        Component()
                        UpdatableComponent()
                    }
                }
            }
        }
        
        let level = game.elements.first as? Level
        let scenario = level?.scenarios.first
        XCTAssertEqual(scenario?.entities.count, 2, "Scenario should contain two entities after initialization")
        
        let e2 = scenario?.entities.last
        XCTAssertNotNil(e2, "The last element should be an entity")
        
        let c = e2?.component(ofType: Component.self)
        XCTAssertNotNil(c, "The entity should have a component")
        
        let uc = e2?.component(ofType: UpdatableComponent.self)
        XCTAssertNotNil(uc, "The entity should have an updatable component")
    }
    
}
