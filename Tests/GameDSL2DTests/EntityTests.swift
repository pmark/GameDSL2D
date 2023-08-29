//
//  EntityTests.swift
//  
//
//  Created by P. Mark Anderson on 8/29/23.
//

import XCTest
import OctopusKit
@testable import GameDSL2D
import GameplayKit

final class EntityTests: XCTestCase {
    
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
        
        _ = Entity("E") {
            Components {
                [
                    component1Closure(),
                    component2Closure(),
                ]
            }
        }
        
        XCTAssertFalse(component1InitCalled, "component1Closure should not be called yet.")
        XCTAssertFalse(component2InitCalled, "component2Closure should not be called yet.")
        
        // Now, trigger the instantiation of the components:
        let components = Components {
            [ component1Closure(), component2Closure() ]
        }
        _ = components.instantiateComponents()
        
        XCTAssertTrue(component1InitCalled, "component1Closure should now be called.")
        XCTAssertTrue(component2InitCalled, "component2Closure should now be called.")
    }
    
}

