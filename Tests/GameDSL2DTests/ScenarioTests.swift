//
//  ScenarioTests.swift
//  
//
//  Created by P. Mark Anderson on 8/27/23.
//

import XCTest
@testable import GameDSL2D

final class ScenarioTests: XCTestCase {
    
    func testScenarioInitialization() {
        let scenario = Scenario(name: "Test Scenario") {
            Entity(type: .player, name: "Test Entity")
        }
        
        XCTAssertEqual(scenario.name, "Test Scenario")
        XCTAssertEqual(scenario.entities.count, 1)
    }
    
    func testScenarioData() {
        let scenario = Scenario(name: "Test Scenario", data: {
            TestGameData(testDataProperty: 3)
        })
        
        XCTAssertNotNil(scenario.data as? TestGameData)
        XCTAssertEqual(scenario.entities.count, 0)
    }
    
    func testTriggerEvaluation() {
        let scenario = Scenario(
            name: "Trigger Test Scenario",
            data: { TestGameData(testDataProperty: 10) }
        ) {
            Trigger(
                emit: .gameOver,
                perform: { (data: TestGameData) in
                    print("action data \(data)")
                },
                when: { (data: TestGameData) in data.testDataProperty == 10 })
        }
        
        if let data = scenario.data as? TestGameData {
            XCTAssertTrue(data.triggers.first?.check(using: data) ?? false)
        } else {
            XCTFail("Trigger evaluation failed.")
        }
    }
    
    func testBasicScenarioInitialization() {
        let scenario = Scenario(name: "Test Scenario") {
            Entity(type: .player, name: "Test Entity")
            
            State(key: ScenarioStateKey.start)
            State(key: ScenarioStateKey.end)
        }
        
        // Check Scenario name
        XCTAssertEqual(scenario.name, "Test Scenario")
        
        // Check the children count (Entity and States)
        XCTAssertEqual(scenario.children.count, 3)
    }
    
    func testScenarioStates() {
        var onEnterCalled = false
        var onExitCalled = false
        let scenario = Scenario(name: "Test Scenario") {
            State(key: .start)
                .didEnter { state in
                    onEnterCalled = true
                    XCTAssertEqual(state.key, AnyKey(.start))
                    XCTAssertEqual(state.parent?.name, "Test Scenario")
                }
                .willExit { state in
                    onExitCalled = true
                    XCTAssertEqual(state.key, AnyKey(.start))
                    XCTAssertEqual(state.parent?.name, "Test Scenario")
                }
        }
        // Check scenario name
        XCTAssertEqual(scenario.name, "Test Scenario")
        // Check children of the scenario to ensure the state is present
        guard let state = scenario.children.first as? State else {
            XCTFail("State not found as child of scenario")
            return
        }
        // Trigger onEnter and onExit to verify they work
        state.triggerOnEnter()
        XCTAssertTrue(onEnterCalled)
        state.triggerOnExit()
        XCTAssertTrue(onExitCalled)
    }
    
    
    //    func testScenarioActivation() {
    //        let scenario = Scenario(name: "Test Scenario") {
    //            Entity("Test Entity")
    //            State(.initializing)
    //            State(.active)
    //            Trigger(condition: { $0.testDataProperty == 0 }, event: .gameOver)
    //        }
    //
    //        scenario.activate() // This should bind the publisher (start watching changes)
    //
    //    }
}
