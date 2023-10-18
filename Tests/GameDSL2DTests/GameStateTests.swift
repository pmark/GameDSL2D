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

    let playScene = Scene(key: .playing)
    
    let pausedScene = Scene(key: .paused)
    
    // MARK: - GameState Tests
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        SceneManager.shared.reset()
    }

    func testGameStateInitialization() {
        let game = Game {
            playScene
            GameState(key: .playing)
        }
        
        // TODO: what if you had multiple scenes in the same game state?
        game.activate()

        if let gameState = game.gameStates.first {
            XCTAssertNotNil(gameState.scene)
            XCTAssertEqual(gameState.scene, playScene)  // Ensure both are the same instance
            XCTAssertNotNil(SceneManager.shared.getScene(for: .playing))
        } else {
            XCTAssert(false, "Game has no game states")
        }
    }

    func testGameStateWithMissingScene() {
        let game = Game {
            GameState(key: .playing)
        }
        
        // TODO: what if you had multiple scenes in the same game state?

        if let gameState = game.gameStates.first {
            XCTAssertNil(gameState.scene)
        }
    }
    
//    func testGameStateWithSwiftUIView() {
//        let v = HUDView()
//        let gameState = GameState(.playing, view: v)
//        XCTAssertEqual(gameState.associatedSwiftUIView as? HUDView, v)
//    }

    // Test multiple game states within a game
    func testMultipleGameStates() {
        let gameState1 = GameState(.playing, view: HUDView())
        let gameState2 = GameState(.paused, view: PausedView())
        
        let game = Game() {
            playScene
            pausedScene
            
            gameState1
            gameState2
        }

        XCTAssertEqual(game.children.count, 4)
        XCTAssert(game.children.contains(where: { $0 as? GameState === gameState1 }))
        XCTAssert(game.children.contains(where: { $0 as? GameState === gameState2 }))
        XCTAssertEqual(game.gameStates.first?.scene, playScene)
        XCTAssertEqual(game.gameStates.last?.scene, pausedScene)
    }
}



