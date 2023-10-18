//
//  Camera.swift
//  
//
//  Created by P. Mark Anderson on 10/6/23.
//

import SpriteKit
import OctopusKit

public class Camera: Entity {
    public var target: EntityIdentifier? = nil
    public var boundary: CGRect? = nil
    public var zoomLevel: CGFloat = 1.0
    
    public init(
        targetIdentifier: EntityIdentifier?,
        boundary: CGRect? = nil,
        zoomLevel: CGFloat = 1.0,
        name: String? = nil,
        data: (() -> GameData)? = nil
    ) {
        self.target = targetIdentifier
        self.boundary = boundary
        self.zoomLevel = zoomLevel
        
        super.init(type: AnyKey(.camera), name: name, data: data)
//        super.init(type: .camera, name: name, data: data)
        
        self.addComponent({ CameraComponent(insetBoundsByScreenSize: true) })
        
        self.onActivate { construct in
            if let this = construct as? Camera {
                this.updateCamera()
            }
        }
    }
    
    public convenience init(
        target: EntityType? = nil,
        boundary: CGRect? = nil,
        zoomLevel: CGFloat = 1.0,
        name: String? = nil,
        data: (() -> GameData)? = nil
    ) {
        let targetId = (target == nil) ? nil : EntityIdentifier(type: target!)
        
        self.init(
            targetIdentifier: targetId,
            boundary: boundary,
            zoomLevel: zoomLevel,
            name: name,
            data: data)
    }
    
    private func updateCamera() {
        if let cc = self.okEntity[CameraComponent.self] {
            if let target = self.target {
                cc.nodeToTrack = EntityRegistry.shared.findEntity(with: target)?.okEntity.node
            }
            
            if let boundary = self.boundary {
                cc.bounds = boundary
            } else {
                if let scene = self.getScene() {
                    cc.bounds = scene.view?.bounds
                }
            }
            
            cc.camera.setScale(self.zoomLevel)
        }
    }

    @discardableResult
    public func useZoom() -> Self {
        // Add ZoomGestureComponent and ZoomComponent
        self.addComponent({ PinchGestureRecognizerComponent() })
        self.addComponent(CameraZoomComponent.self)
        return self
    }
    
    @discardableResult
    public func usePan() -> Self {
        // Add PanGestureComponent and PanComponent
        self.addComponent(PanGestureRecognizerComponent.self)
        self.addComponent({ CameraPanComponent() })
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
