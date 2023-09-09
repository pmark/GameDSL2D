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

    // MARK: - Setup & Teardown

    override func setUpWithError() throws {
        // Place setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Place teardown code here. This method is called after the invocation of each test method in the class.
    }

    // MARK: - GameState Tests

    func testGameStateInitialization() {
        let scene = Scene(name: "TestScene")
        let gameState = GameState(scene: scene)

        XCTAssertNotNil(gameState)
        XCTAssert(gameState.associatedScene === scene)  // Ensure both are the same instance
        XCTAssertNil(gameState.associatedSwiftUIView)   // Should be nil by default
    }

    func testGameStateWithSwiftUIView() {
        let scene = Scene(name: "TestScene")
        let swiftUIView = "TestView"  // Replace with your actual SwiftUI view type if necessary
        let gameState = GameState(scene: scene, swiftUIView: swiftUIView)

        XCTAssertNotNil(gameState)
        XCTAssertEqual(gameState.associatedSwiftUIView as? String, swiftUIView)
    }

    func testGameStateInstantiatesCorrectOKGameState() {
        let scene = Scene(name: "TestScene")
        let gameState = GameState(scene: scene)
        guard let okGameState = gameState.instantiateOKGameState() as? CustomOKGameState else {
            XCTFail("Can't get GameState from scene")
            return
        }

        let stateSceneType = okGameState.getSceneType()
        let sceneType = type(of: scene.okScene)
        XCTAssert(stateSceneType === sceneType)
    }

    // Test multiple game states within a game
    func testMultipleGameStates() {
        let scene1 = Scene(name: "Scene1")
        let scene2 = Scene(name: "Scene2")
        let gameState1 = GameState(scene: scene1)
        let gameState2 = GameState(scene: scene2, swiftUIView: "TestView")
        
        let game = Game(name: "MyGame") {
            gameState1
            gameState2
        }

        XCTAssertEqual(game.children.count, 2)
        XCTAssert(game.children.contains(where: { $0 as? GameState === gameState1 }))
        XCTAssert(game.children.contains(where: { $0 as? GameState === gameState2 }))
    }
    
    // MARK: - Performance Tests

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            _ = GameState(scene: Scene(name: "TestScene"))
        }
    }
}

