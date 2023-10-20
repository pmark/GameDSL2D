//
//  EntityTests.swift
//  
//
//  Created by P. Mark Anderson on 8/29/23.
//

@testable import GameDSL2D
import XCTest
import OctopusKit
import GameplayKit



final class EntityTests: XCTestCase {
    func testEntityInitialization() {
        let entity = Entity(type: .player, name: "E1")
        XCTAssertEqual(entity.componentInitializers.count, 0, "Should have zero component initializers")
    }
    
    func testEntityComponents() {
        let entity = Entity(type: .player, name: "E2") {
            Components {[
                TestComponent(),
                TestComponent2(),
            ]}
        }
        XCTAssertEqual(entity.componentInitializers.count, 1, "Should have 2 component initializers")
        XCTAssertEqual(entity.components.count, 2, "Should have 2 components")
    }
    
    func testOKComponents() {
        let entity = Entity(type: .player, name: "E3") {
            Components {[
                SpriteKitComponent(node: SKNode())
            ]}
        }
        XCTAssertEqual(entity.componentInitializers.count, 1, "Should have 1 component initializer")
        XCTAssertEqual(entity.components.count, 1, "Should have 1 component")
    }
    
    func testLazyComponentInitialization() {
        var component1InitCalled = false
        var component2InitCalled = false
        
        let component1Closure: () -> OKComponent = {
            component1InitCalled = true
            return OKComponent() // Replace with actual OKComponent subclass
        }
        
        let component2Closure: () -> OKComponent = {
            component2InitCalled = true
            return OKComponent() // Replace with actual OKComponent subclass
        }
        
        _ = Entity(type: .player, name: "EntityTests Player") {
            Components {[
                component1Closure(),
                component2Closure(),
            ]}
        }
        
        XCTAssertFalse(component1InitCalled, "component1Closure should not be called yet.")
        XCTAssertFalse(component2InitCalled, "component2Closure should not be called yet.")
        
        // Now, trigger the instantiation of the components:
        let components = Components {[
            component1Closure(),
            component2Closure(),
        ]}
        _ = components.instantiateComponents()
        
        XCTAssertTrue(component1InitCalled, "component1Closure should now be called.")
        XCTAssertTrue(component2InitCalled, "component2Closure should now be called.")
    }
    
    func testEntityData() {
        let entity = Entity(
            type: .player,
            name: "Test Entity",
            data: { TestGameData(testDataProperty: 3) }
        ) {}
        
        XCTAssertEqual(entity.name, "Test Entity")
        
        let gameData = entity.data as? TestGameData
        XCTAssertNotNil(gameData)
        if let data = gameData {
            XCTAssertEqual(data.testDataProperty, 3)
        } else {
            XCTFail("Expected AnotherGameData type")
        }
    }
    
    func testEntityDataWithChild() {
        let entity = Entity(
            type: .player, name: "Test Entity",
            data: { TestGameData(testDataProperty: 3) }
        ) {
            State(key: EntityStateKey.active)
        }
        
        XCTAssertEqual(entity.name, "Test Entity")
        
        let gameData = entity.data as? TestGameData
        XCTAssertNotNil(gameData)
        if let data = gameData {
            XCTAssertEqual(data.testDataProperty, 3)
        } else {
            XCTFail("Expected AnotherGameData type")
        }
    }
    
    func testEntityState() {
        let entity = Entity(
            type: .player,
            name: "Test Entity",
            data: { TestGameData(testDataProperty: 3) }
        ) {
            State(key: .alive)
            State(key: .dead)
            
            Trigger<TestGameData>(emit: .gameOver) { testGameData in
                testGameData.testDataProperty == 0
            }
        }
            .setStateOn(event: .gameOver, to: AnyKey(.dead))
        
        XCTAssertEqual(entity.states.count, 2)
        XCTAssertEqual(entity.data?.triggers.count, 1)
        XCTAssertEqual(entity.eventTokens.count, 1)
    }
}

