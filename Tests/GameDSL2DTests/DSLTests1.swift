//
//  DSLTests1.swift
//  
//
//  Created by P. Mark Anderson on 8/27/23.
//

import XCTest
import OctopusKit
@testable import GameDSL2D

final class DSLTests1: XCTestCase {
    class func silencio() {
        OctopusKit.logForDebug.disabled = true
        OctopusKit.logForTips.disabled  = true
        OctopusKit.logForErrors.disabled = true
        OctopusKit.logForDeinits.disabled = true
        OctopusKit.logForStates.disabled = true
        OctopusKit.logForComponents.disabled = true
        OctopusKit.logForFramework.disabled = true
        OctopusKit.logForWarnings.disabled = true
        OctopusKit.logForResources.disabled = true
    }
    
    override class func setUp() {
        super.setUp()
        silencio()
    }
}

class TestGameData: GameData {
    @Published var testDataProperty: Int

    init(testDataProperty: Int) {
        self.testDataProperty = testDataProperty
    }
}

class AnotherGameData: GameData {
    var someValue: String

    init(someValue: String) {
        self.someValue = someValue
    }
}
