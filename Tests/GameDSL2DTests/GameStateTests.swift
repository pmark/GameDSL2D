//
//  GameStateTests.swift
//  
//
//  Created by P. Mark Anderson on 9/8/23.
//

import XCTest
@testable import GameDSL2D
import OctopusKit

class GameStateTests: XCTestCase {

    // MARK: - GameState Tests

    func testGameStateInitialization() {
//        let scene = Scene(sceneIdentifier: .playing) {}
//        let gameState = GameState(.playing)
        // TODO: what if you had multiple scenes in the same game state?

//        XCTAssertNotNil(gameState)
//        XCTAssert(gameState.associatedScene === scene)  // Ensure both are the same instance
//        XCTAssertNil(gameState.associatedSwiftUIView)   // Should be nil by default
    }

    func testGameStateWithSwiftUIView() {
//        let _ = Scene(sceneIdentifier: .playing) {}
//        let gameState = GameState(.playing, sceneIdentifier: .playing, view: HUDView())

//        XCTAssertNotNil(gameState)
//        XCTAssertEqual(gameState.associatedSwiftUIView as? String, swiftUIView)
    }

    func testGameStateInstantiatesCorrectOKGameState() {
//        let scene = Scene(sceneIdentifier: .playing) {}
//        let gameState = GameState(.playing, sceneIdentifier: .playing)
//        guard let okGameState = gameState.instantiateOKGameState() as? CustomOKGameState else {
//            XCTFail("Can't get GameState from scene")
//            return
//        }

//        let stateSceneType = okGameState.associatedSceneClass
//        let sceneType = type(of: scene.okScene)
//        XCTAssert(stateSceneType === sceneType)
    }

    // Test multiple game states within a game
    func testMultipleGameStates() {
        let _ = Scene(sceneIdentifier: .playing) {}
        let _ = Scene(sceneIdentifier: .paused) {}
        let gameState1 = GameState(.playing, sceneIdentifier: .playing)
        let gameState2 = GameState(.paused, sceneIdentifier: .paused, view: PausedView())
        
        let game = Game(name: "MyGame") {
            gameState1
            gameState2
        }

        XCTAssertEqual(game.children.count, 2)
        XCTAssert(game.children.contains(where: { $0 as? GameState === gameState1 }))
        XCTAssert(game.children.contains(where: { $0 as? GameState === gameState2 }))
    }
    
    func testInit1() {
        let _ = Scene(sceneIdentifier: .paused) {}

        let game = Game {
            GameState(.paused, sceneIdentifier: .paused)
        }
    }
}



