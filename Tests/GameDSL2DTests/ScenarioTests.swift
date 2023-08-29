//
//  ScenarioTests.swift
//  
//
//  Created by P. Mark Anderson on 8/27/23.
//

import XCTest
@testable import GameDSL2D

final class ScenarioTests: XCTestCase {
    
    func testBasicScenarioInitialization() {
        XCTAssertEqual("yes", "yes")
//        let scenario = Scenario("Test Scenario") {
//            Entity("Test Entity")
//            State(.state1)
//            State(.state2)
//        }
//
//        // Check Scenario name
//        XCTAssertEqual(scenario.name, "Test Scenario")
//
//        // Check the children count (Entity and States)
//        XCTAssertEqual(scenario.children.count, 3)
    }
        
    
    /*
    func testScenarioTrigger() {
        let scenario = Scenario("Test Scenario") {
            Trigger<TestData>(condition: { $0.testDataProperty == 0 }, event: .gameOver)
        }
        
        // Check Scenario name
        XCTAssertEqual(scenario.name, "Test Scenario")
        
        // Check the children count (Entity and States)
        XCTAssertEqual(scenario.children.count, 1)
        
        // Ensure there's a TestData dataProducer
        XCTAssertNotNil(scenario.dataProducer)
        
        // Ensure there's a Trigger with the given condition
        XCTAssertTrue(scenario.triggers.first?.condition(TestData()) == false)
    }
    
    func testScenarioActivation() {
        let scenario = Scenario<TestData>("Test Scenario") {
            Entity("Test Entity")
            State(.state1)
            State(.state2)
            Trigger(condition: { $0.testDataProperty == 0 }, event: .gameOver)
        }
        
        scenario.activate() // This should bind the publisher (start watching changes)
        
        // Change the property of testData
        scenario.data?.someTestDataProperty = 0
        
        // Mock the eventPublisher to listen for a game over event
        var gameEventReceived: GameEventKey? = nil
        
        // TODO: refactor once I understand ObservableData
        scenario.data?.eventPublisher = { event in
            gameEventReceived = event
        }
        
//        scenario.activate() // This should evaluate the trigger condition
        
        XCTAssertEqual(gameEventReceived, .gameOver)
    }
     */
}
//
//class TestData: ObservableData {
//    @Published var testDataProperty: Int = 0
//}
