//
//  DSLTests1.swift
//  
//
//  Created by P. Mark Anderson on 8/27/23.
//

import XCTest
@testable import GameDSL2D

final class DSLTests1: XCTestCase {
    
    func testScenarioInitialization() {
        let scenario = Scenario("Test Scenario") {
            Entity("Test Entity")
        }
        
        XCTAssertEqual(scenario.name, "Test Scenario")
    }
    
    func testScenarioData() {
        let scenario = Scenario("Test Scenario") {
            LazyData {
                TestGameData(testDataProperty: 3)
            }
        }
        
        XCTAssertNotNil(scenario.data as? TestGameData)
    }
    
    func testScenarioStates() {
        var onEnterCalled = false
        var onExitCalled = false
        
        let scenario = Scenario("Test Scenario") {
            State(.state1)
                .onEnter { state in
                    onEnterCalled = true
                    XCTAssertEqual(state.key, .state1)
                    XCTAssertEqual(state.parent?.name, "Test Scenario")
                    print("Entered state \(state.key) in scenario \(state.parent?.name ?? "?")")
                }
                .onExit { state in
                    onExitCalled = true
                    XCTAssertEqual(state.key, .state1)
                    XCTAssertEqual(state.parent?.name, "Test Scenario")
                    print("About to exit state \(state.key) in scenario \(state.parent?.name ?? "?")")
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

    
    func testEntityInitialization() {
        let entity = Entity("Test Entity") {
            State(.state2)
            LazyData {
                TestGameData(testDataProperty: 3)
            }
        }
        
        XCTAssertEqual(entity.name, "Test Entity")
        XCTAssertNotNil(entity.data as? TestGameData)
    }
    
    func testStateInitialization() {
        let state = State(.state1)
        
        XCTAssertEqual(state.key, .state1)
    }
    
    func testLazyDataInitialization() {
        let scenario = Scenario("Another Test Scenario") {
            LazyData {
                AnotherGameData(someValue: "TestValue")
            }
        }
        
        if let data = scenario.data as? AnotherGameData {
            XCTAssertEqual(data.someValue, "TestValue")
        } else {
            XCTFail("Expected AnotherGameData type")
        }
    }
    
func testTriggerEvaluation() {
    let scenario = Scenario("Trigger Test Scenario") {
        LazyData {
            TestGameData(testDataProperty: 10)
        }
        
        Trigger(
            event: .gameOver,
            action: { (data: TestGameData) in
                print("action data \(data)")
            },
            condition: { (data: TestGameData) in data.testDataProperty == 10 })
    }
    
    if let data = scenario.data as? TestGameData {
        XCTAssertTrue(data.triggers.first?.check(using: data) ?? false)
    } else {
        XCTFail("Trigger evaluation failed.")
    }
}

}

class TestGameData: GameData {
    @Published var testDataProperty: Int

    init(testDataProperty: Int) {
        self.testDataProperty = testDataProperty
    }
}

class AnotherGameData: GameData {
    var someValue: String

    init(someValue: String) {
        self.someValue = someValue
    }
}
