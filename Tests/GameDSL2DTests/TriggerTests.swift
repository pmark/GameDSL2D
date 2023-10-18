//
//  TriggerTests.swift
//  
//
//  Created by P. Mark Anderson on 10/18/23.
//

import XCTest
@testable import GameDSL2D

class ExtendedGameData: GameData {
    var specialProperty: Int = 0
}

final class TriggerTests: XCTestCase {
    
    var gameData: GameData!
    
    override func setUp() {
        super.setUp()
        // Initialize gameData for testing
        gameData = GameData()
    }
    
    func testCheckConditionTrue() {
        let trigger = Trigger(emit: .gameOver) { _ in
            return true
        }
        
        XCTAssertTrue(trigger.check(using: gameData))
    }
    
    func testCheckConditionFalse() {
        let trigger = Trigger(emit: .gameOver) { _ in
            return false
        }
        
        XCTAssertFalse(trigger.check(using: gameData))
    }
    
    func testEvaluatesCondition() {
        var didEvaluate = false
        let trigger = Trigger(perform: { _ in didEvaluate = true }) { _ in
            return true
        }
        
        trigger.evaluate(using: gameData)
        XCTAssertTrue(didEvaluate)
    }
    
    func testDoesNotEvaluateCondition() {
        var didEvaluate = false
        let trigger = Trigger(perform: { _ in didEvaluate = true }) { _ in
            return false
        }
        
        trigger.evaluate(using: gameData)
        XCTAssertFalse(didEvaluate)
    }
    
    func testEmitsEvent() {
        let expectation = self.expectation(description: "Should receive event notification")
        let testEventKey = "TestEvent"
        let trigger = Trigger<GameData>(emit: AnyKey(testEventKey), perform: nil) { _ in true }
        
        let observer = NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: testEventKey), object: nil, queue: nil) { _ in
            expectation.fulfill()
        }
        
        trigger.evaluate(using: gameData)
        
        waitForExpectations(timeout: 1) { _ in
            NotificationCenter.default.removeObserver(observer)
        }
    }
    
    func testCheckConditionWithExtendedGameData() {
        let extendedGameData = ExtendedGameData()
        extendedGameData.specialProperty = 10
        
        let trigger = Trigger<ExtendedGameData>(emit: .gameOver) { data in
            return data.specialProperty > 5
        }
        
        XCTAssertTrue(trigger.check(using: extendedGameData))
    }
    
    func testEvaluatesConditionWithExtendedGameData() {
        let extendedGameData = ExtendedGameData()
        extendedGameData.specialProperty = 10
        
        var didEvaluate = false
        
        let trigger = Trigger<ExtendedGameData>(perform: { _ in didEvaluate = true }) { data in
            return data.specialProperty > 5
        }
        
        trigger.evaluate(using: extendedGameData)
        XCTAssertTrue(didEvaluate)
    }
}
