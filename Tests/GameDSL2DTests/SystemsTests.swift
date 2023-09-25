//
//  SystemsTests.swift
//
//
//  Created by P. Mark Anderson on 9/21/23.
//

import XCTest
@testable import GameDSL2D

final class SystemsTests: XCTestCase {

    func testSystemsInitialization() {
        let systems = Systems(name: "")
        XCTAssertNotNil(systems)
    }
    
    func testComponentTypes() {
        let systems = Systems(name: "") {
            TestComponent.self
        }
        
        XCTAssertNotNil(systems.componentTypes)
        XCTAssertEqual(systems.componentTypes.count, 1)
    }
}
