//
//  StateTests.swift
//  
//
//  Created by P. Mark Anderson on 9/8/23.
//

import XCTest
@testable import GameDSL2D

final class StateTests: XCTestCase {

    func testStateInitialization() {
        let state = State(.state1)
        XCTAssertEqual(state.key, .state1)
    }
    
    func testEvents() {
        var onEnterCalled = false
        var onExitCalled = false
        let state = State(.state1)
            .onEnter { state in
                onEnterCalled = true
                XCTAssertEqual(state.key, .state1)
            }
            .onExit { state in
                onExitCalled = true
                XCTAssertEqual(state.key, .state1)
            }
        
        // Trigger onEnter and onExit to verify they work
        state.triggerOnEnter()
        XCTAssertTrue(onEnterCalled)
        state.triggerOnExit()
        XCTAssertTrue(onExitCalled)
    }
}
