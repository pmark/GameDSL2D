//
//  AnyKeyTests.swift
//  
//
//  Created by P. Mark Anderson on 10/17/23.
//

import XCTest
@testable import GameDSL2D

extension AnyKey {
    init(_ key: AnyKeyTests.MockStateKey) {
        self.init(value: key as any KeyProtocol)
    }
}

class AnyKeyTests: XCTestCase {
    
    enum MockStateKey: String, KeyProtocol {
        case loading = "Loading"
        case running = "Running"
    }
    
    func testEqualityWithStrings() {
        let anyKey1 = AnyKey("Testing")
        let anyKey2 = AnyKey("Testing")
        
        XCTAssertEqual(anyKey1, anyKey2)
    }
    
    func testEqualityWithEnum() {
        let anyKey1 = AnyKey(MockStateKey.loading)
        let anyKey2 = AnyKey(.loading)
        
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
        let anyKey = AnyKey(MockStateKey.loading)
        XCTAssertEqual(anyKey.stringValue, "Loading")
    }
}
