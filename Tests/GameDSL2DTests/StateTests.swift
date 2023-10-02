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
        let state = State(key: .initializing)
        XCTAssertEqual(state.key, AnyKey(StateKey.initializing))
    }
    
    func testEvents() {
        var onEnterCalled = false
        var onExitCalled = false
        let state = State(key: StateKey.initializing)
            .didEnter { state in
                onEnterCalled = true
                XCTAssertEqual(state.key, AnyKey(StateKey.initializing))
            }
            .willExit { state in
                onExitCalled = true
                XCTAssertEqual(state.key, AnyKey(StateKey.initializing))
            }
        
        // Trigger onEnter and onExit to verify they work
        state.triggerOnEnter()
        XCTAssertTrue(onEnterCalled)
        state.triggerOnExit()
        XCTAssertTrue(onExitCalled)
    }
}
