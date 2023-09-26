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

class TestComponent: ComponentType {
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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

final class EntityTests: XCTestCase {
    func testEntityInitialization() {
        let entity = Entity(name: "E") {}
        XCTAssertEqual(entity.componentConstructs.count, 0, "Should have zero component constructs")
    }
    
    func testEntityComponents() {
        let entity = Entity(name: "E") {
            Components {[
                TestComponent(),
                TestComponent2(),
            ]}
        }
        XCTAssertEqual(entity.componentConstructs.count, 1, "Should have 1 component constructs")
        XCTAssertEqual(entity.components.count, 2, "Should have 2 components")
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
        
        _ = Entity(name: "E") {
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
            name: "Test Entity",
            data: { TestGameData(testDataProperty: 3) }
        )
        
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
            name: "Test Entity",
            data: { TestGameData(testDataProperty: 3) }
        ) {
            State(.active)
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
}

