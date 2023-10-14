//
//  ComponentInitializerTests.swift
//  
//
//  Created by P. Mark Anderson on 10/10/23.
//

import XCTest
@testable import GameDSL2D
import GameplayKit

final class ComponentInitializerTests: XCTestCase {

    func testNoInitializers() {
            let componentInit = ComponentInitializer()
            let components = componentInit.instantiate()
            XCTAssertEqual(components.count, 0)
        }

        func testSingleInitializer() {
            let c = TestComponent()
            let componentInit = ComponentInitializer(single: { return c })
            let components = componentInit.instantiate()
            XCTAssertEqual(components.count, 1)
            XCTAssertEqual(components.first!, c)
        }
        
        func testMultiInitializer() {
            let c1 = TestComponent()
            let c2 = TestComponent()
            let both = [c1, c2]
            let componentInit = ComponentInitializer(multi: { both })
            let components = componentInit.instantiate()
            XCTAssertEqual(components.count, 2)
            XCTAssertEqual(components, both)
        }
        
        func testBothInitializers() {
            let c1 = TestComponent()
            let c2 = TestComponent()
            let c3 = TestComponent()
            let both = [c2, c3]
            
            let componentInit = ComponentInitializer(single: { c1 }, multi: { both })
            let components = componentInit.instantiate()
            XCTAssertEqual(components.count, 3)
            XCTAssertEqual(components.first, c1)
            XCTAssertEqual(components[1], c2)
            XCTAssertEqual(components.last, c3)
        }

}
