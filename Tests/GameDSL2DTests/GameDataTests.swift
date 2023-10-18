//
//  GameDataTests.swift
//  
//
//  Created by P. Mark Anderson on 10/14/23.
//

import XCTest
@testable import GameDSL2D

final class GameDataTests: XCTestCase {
    
    // Test initial data setting in constructor
    func testInitialDataSetting() {
        let initialData: [String: Any] = ["health": 100, "name": "player1"]
        let gameData = GameData(initialData)
        
        if let health: Int = gameData.get("health") {
            XCTAssertEqual(health, 100)
        } else {
            XCTFail("Expected health to be 100, but it was nil or not an Int.")
        }
        
        if let name: String = gameData.get("name") {
            XCTAssertEqual(name, "player1")
        } else {
            XCTFail("Expected name to be 'player1', but it was nil or not a String.")
        }
    }
    
    // Test setting new values
    func testValueSetting() {
        let gameData = GameData()
        gameData.set("ammo", value: 20)
        
        if let ammo: Int = gameData.get("ammo") {
            XCTAssertEqual(ammo, 20)
        } else {
            XCTFail("Expected ammo to be 20, but it was nil or not an Int.")
        }
    }
    
    // Test updating existing values
    func testValueUpdating() {
        let gameData = GameData(["health": 50])
        gameData.set("health", value: 100)
        
        if let health: Int = gameData.get("health") {
            XCTAssertEqual(health, 100)
        } else {
            XCTFail("Expected health to be 100, but it was nil or not an Int.")
        }
    }
    
    // Test retrieving non-existing keys
    func testNonExistingKeys() {
        let gameData = GameData()
        
        let value: Int? = gameData.get("nonexistent")
        XCTAssertNil(value, "Expected 'nonexistent' key to return nil, but it returned a value.")
    }
    
    // Test storing and retrieving different types
    func testMultipleTypes() {
        let gameData = GameData()
        gameData.set("isAlive", value: true)
        
        if let isAlive: Bool = gameData.get("isAlive") {
            XCTAssertTrue(isAlive)
        } else {
            XCTFail("Expected isAlive to be true, but it was nil or not a Bool.")
        }
    }
}
