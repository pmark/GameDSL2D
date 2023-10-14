//
//  Camera.swift
//  
//
//  Created by P. Mark Anderson on 10/6/23.
//

import SpriteKit
import OctopusKit

public class Camera: Entity {
    
    public init(name: String? = nil, @GameConstructBuilder childConstructs: () -> [Any]) {
        super.init(type: AnyKey(.camera), name: name, data: nil, childConstructs: childConstructs)
        
        self.addComponent({ CameraComponent(insetBoundsByScreenSize: true) })
        
        self.onActivate { _ in
//            guard let scene = self(SpriteKitSceneComponent.self)?.scene else {
//                return
//            }
            
            if let cc = self.okEntity[CameraComponent.self] {
                cc.nodeToTrack = EntityRegistry.shared.findEntity(ofType: .player)?.okEntity.node
            }
        }
    }

    @discardableResult
    public func useZoom() -> Self {
        // Add ZoomGestureComponent and ZoomComponent
        self.addComponent(PinchGestureRecognizerComponent.self)
        self.addComponent(CameraZoomComponent.self)
        return self
    }
    
    @discardableResult
    public func usePan() -> Self {
        // Add PanGestureComponent and PanComponent
        self.addComponent(PanGestureRecognizerComponent.self)
        self.addComponent(CameraPanComponent.self)
        return self
    }
    
    @discardableResult
    public func configure(_ closure: (SKCameraNode) -> Void) -> Self {
        guard
            let scene = self.okEntity.component(ofType: SpriteKitSceneComponent.self)?.scene,
            let cameraNode = scene.camera else {
            print("WARNING: Missing camera node")
            return self
        }
        
        closure(cameraNode)
        return self
    }
}
