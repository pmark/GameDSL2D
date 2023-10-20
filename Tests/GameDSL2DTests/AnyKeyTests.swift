//
//  AnyKeyTests.swift
//  
//
//  Created by P. Mark Anderson on 10/17/23.
//

import XCTest
@testable import GameDSL2D

class AnyKeyTests: XCTestCase {
    
    func testEqualityWithStrings() {
        let anyKey1 = AnyKey("Testing")
        let anyKey2 = AnyKey("Testing")
        
        XCTAssertEqual(anyKey1, anyKey2)
    }
    
    func testEqualityWithEnum() {
        let anyKey1 = AnyKey(.alive)
        let anyKey2 = AnyKey(.alive)
        
        XCTAssertEqual(anyKey1, anyKey2)
    }
    
    func testInequality() {
        let anyKey1 = AnyKey("Testing")
        let anyKey2 = AnyKey("Testing2")
        
        XCTAssertNotEqual(anyKey1, anyKey2)
    }
    
    func testHashValues() {
        let anyKey1 = AnyKey("Testing")
        let anyKey2 = AnyKey("Testing")
        
        XCTAssertEqual(anyKey1.hashValue, anyKey2.hashValue)
    }
    
    func testStringValue() {
        let anyKey = AnyKey(.loading)
        XCTAssertEqual(anyKey.stringValue, "loading")
    }
}
