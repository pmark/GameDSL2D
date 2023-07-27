//
//  DSLGame.swift
//  
//
//  Created by P. Mark Anderson on 7/24/23.
//

import XCTest
@testable import GameDSL2D

final class GameInitializationTests: XCTestCase {
    
    // Test for game initialization with no elements
       func testEmptyGameInitialization() {
           let game = DSLGame {
               // No elements
           }
           XCTAssertEqual(game.elements.count, 0, "Game should be empty after initialization")
       }
       
       // Test for game initialization with one level
       func testSingleLevelInitialization() {
           let game = DSLGame {
               Level("Test Level")
           }
           XCTAssertEqual(game.elements.count, 1, "Game should contain one level after initialization")
           XCTAssert(game.elements.first is DSLLLevel, "The first element should be a level")
       }
       
       // Test for game initialization with multiple levels
       func testMultiLevelInitialization() {
           let game = DSLGame {
               Level("Test Level 1")
               Level("Test Level 2")
               Level("Test Level 3")
           }
           XCTAssertEqual(game.elements.count, 3, "Game should contain three levels after initialization")
       }
       
       // Test for game initialization with one level and one scenario
       func testLevelWithSingleScenarioInitialization() {
           let game = DSLGame {
               Level("Test Level") {
                   Scenario("Test Scenario")
               }
           }
           XCTAssertEqual(game.elements.count, 1, "Game should contain one level after initialization")
           let level = game.elements.first as? DSLLLevel
           XCTAssertNotNil(level, "The first element should be a level")
           XCTAssertEqual(level?.scenarios.count, 1, "Level should contain one scenario after initialization")
       }
       
       // Test for game initialization with one level and multiple scenarios
       func testLevelWithMultiScenarioInitialization() {
           let game = DSLGame {
               Level("Test Level") {
                   Scenario("Test Scenario 1")
                   Scenario("Test Scenario 2")
               }
           }
           XCTAssertEqual(game.elements.count, 1, "Game should contain one level after initialization")
           let level = game.elements.first as? DSLLLevel
           XCTAssertNotNil(level, "The first element should be a level")
           XCTAssertEqual(level?.scenarios.count, 2, "Level should contain two scenarios after initialization")
       }
       
       // Test for game initialization with entities
       func testLevelWithEntitiesInitialization() {
           let game = DSLGame {
               Level("Test Level") {
                   Scenario("Test Scenario") {
                       Entity("Test Entity 1")
                       Entity("Test Entity 2")
                   }
               }
           }
           let level = game.elements.first as? DSLLLevel
           let scenario = level?.scenarios.first
           XCTAssertEqual(scenario?.entities.count, 2, "Scenario should contain two entities after initialization")
       }
       

}
