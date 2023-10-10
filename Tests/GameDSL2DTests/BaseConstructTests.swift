//
//  BaseConstructTests.swift
//  
//
//  Created by P. Mark Anderson on 10/6/23.
//

import XCTest
@testable import GameDSL2D

class BaseConstructTests: XCTestCase {
    func testOnActivateIsCalled() {
        let expectation = self.expectation(description: "onActivate should be called")
        
        let construct = BaseConstruct()
            .onActivate { _ in
                expectation.fulfill()
            }
        
        construct.activate()
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testOnDeactivateIsCalled() {
        let expectation = self.expectation(description: "onDeactivate should be called")
        
        let construct = BaseConstruct()
            .onDeactivate { _ in
                expectation.fulfill()
            }
        
        construct.deactivate()
        
        waitForExpectations(timeout: 1, handler: nil)
    }

}
