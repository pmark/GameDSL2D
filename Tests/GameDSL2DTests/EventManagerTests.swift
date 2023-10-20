//
//  EventManagerTests.swift
//  
//
//  Created by P. Mark Anderson on 10/14/23.
//

import XCTest
@testable import GameDSL2D

extension Notification.Name {
    static let playerScored = Notification.Name("playerScored")
    static let scoreUpdate = Notification.Name("scoreUpdate")
    static let gameOver = Notification.Name("gameOver")
    static let highScore = Notification.Name("highScore")
}

class EventManagerTests: XCTestCase {
    
    var eventManager: EventManager!
    var construct: BaseConstruct!
    
    override func setUp() {
        super.setUp()
        eventManager = EventManager.shared
        construct = BaseConstruct()
        construct.activate()
    }
    
    override func tearDown() {
        eventManager = nil
        construct = nil
        super.tearDown()
    }
    
    // Test if global events can be emitted and observed
    func testGlobalEventEmission() {
        let expectation = self.expectation(description: "Global event should be emitted")
        
        construct.onEvent(.playerScored) { _, _ in
            expectation.fulfill()
        }
        
        construct.emit(.playerScored)
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    // Test if local events can be emitted and observed
    func testLocalEventEmission() {
        let expectation = self.expectation(description: "Local event should be emitted to target")
        
        let anotherConstruct = BaseConstruct()
        
        let construct = BaseConstruct()
        construct.onEvent(.scoreUpdate) { construct, _ in
            if let entity = construct as? Entity {
                entity.enterConditionState(.poisoned)
            }
            expectation.fulfill()
        }
        
        construct.emit(.scoreUpdate, target: construct)
        anotherConstruct.emit(.scoreUpdate, target: anotherConstruct) // should not trigger the event on `construct`
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    // Test event emission with additional data
    func testEventWithData() {
        let expectation = self.expectation(description: "Event should be emitted with data")
        
        construct.onEvent(.highScore) { _, userInfo in
            if let score = userInfo?["score"] as? Int, score == 50 {
                expectation.fulfill()
            }
        }
        
        construct.emit(.highScore, userInfo: ["score": 50])
        
        waitForExpectations(timeout: 1, handler: nil)
    }
}
