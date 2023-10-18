//
//  CameraTests.swift
//  
//
//  Created by P. Mark Anderson on 9/26/23.
//

import XCTest
@testable import GameDSL2D
import SpriteKit
import OctopusKit

final class CameraTests: XCTestCase {
    
    var camera: Camera!
    var entityRegistry: EntityRegistry!
    var testEntity: GameDSL2D.Entity!
    var scene: OKScene!

    override func setUpWithError() throws {
        super.setUp()
        
        entityRegistry = EntityRegistry.shared
        scene = OKScene(size: CGSize(width: 400, height: 400))
        
        testEntity = Entity(type: .player)
        entityRegistry.register(type: .player, name: "player1", entity: testEntity)
    }
    
    override func tearDownWithError() throws {
        camera = nil
        entityRegistry = nil
        testEntity = nil
        scene = nil
        
        super.tearDown()
    }
    
    func testInitialization() {
        camera = Camera(target: .player)
        XCTAssertNotNil(camera)
        
        XCTAssertEqual(camera.target, EntityIdentifier(type: .player))
        XCTAssertNil(camera.boundary)
        XCTAssertEqual(camera.zoomLevel, 1.0)
    }
    
    func testUpdateCamera() {
        camera = Camera(target: .player)
        
        let cameraComponent = camera.okEntity[CameraComponent.self]
        
        XCTAssertNotNil(cameraComponent)
        
        // More assertions depending on your CameraComponent implementation.
    }
    
    func testZoomUsage() {
        camera = Camera()
        
        camera.useZoom()
        
        XCTAssertTrue(camera.okEntity[PinchGestureRecognizerComponent.self] != nil)
        XCTAssertTrue(camera.okEntity[CameraZoomComponent.self] != nil)
    }
    
    func testPanUsage() {
        camera = Camera()
        
        camera.usePan()
        
        XCTAssertTrue(camera.okEntity[PanGestureRecognizerComponent.self] != nil)
        XCTAssertTrue(camera.okEntity[CameraPanComponent.self] != nil)
    }
    
    func testConfigure() {
        let cameraNode = SKCameraNode()
        scene.camera = cameraNode
        camera = Camera()
        camera.addComponent({ SpriteKitSceneComponent(scene: self.scene) })
        
        camera.configure { cameraNode in
            cameraNode.setScale(2.0)
        }
        
        XCTAssertEqual(cameraNode.xScale, 2.0)
        XCTAssertEqual(cameraNode.yScale, 2.0)
    }
    
    // Additional tests can include boundary setting, zoom level constraints, etc.
}
