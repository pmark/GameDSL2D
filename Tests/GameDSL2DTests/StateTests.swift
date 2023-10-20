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
        let state = State(key: .alive)
        XCTAssertEqual(state.key, AnyKey(.alive))
    }
    
    func testEvents() {
        var onEnterCalled = false
        var onExitCalled = false
        let state = State(key: EntityStateKey.active.rawValue)
            .didEnter { state in
                onEnterCalled = true
                XCTAssertEqual(state.key, AnyKey(EntityStateKey.active))
            }
            .willExit { state in
                onExitCalled = true
                XCTAssertEqual(state.key, AnyKey(EntityStateKey.active))
            }
        
        // Trigger onEnter and onExit to verify they work
        state.triggerOnEnter()
        XCTAssertTrue(onEnterCalled)
        state.triggerOnExit()
        XCTAssertTrue(onExitCalled)
    }
}
