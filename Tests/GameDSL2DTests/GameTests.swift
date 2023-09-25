//
//  GameTests.swift
//  
//
//  Created by P. Mark Anderson on 9/21/23.
//

import XCTest
@testable import GameDSL2D

final class GameTests: XCTestCase {

    func testInit1() throws {
        let game = Game {
            scene1
        }
        
        XCTAssertEqual(game.scenes.count, 1)
    }

    func testInit2() throws {
        let game = Game(name: "Game1", data: { TestGameData() }) {
            scene1
        }
        
        XCTAssertEqual(game.scenes.count, 1)
    }
    
//    func testInit3() throws {
//        let game = Game {
//            GameState(.playing)
//        }
//        
//        XCTAssertEqual(game.scenes.count, 1)
//    }

    let scene1 = Scene(sceneIdentifier: .playing) {
        Scenario {
            Entity()
        }
    }

}
