//
//  File.swift
//  
//
//  Created by P. Mark Anderson on 9/8/23.
//

import OctopusKit

class CustomOKGameState: OKGameState {
    private let associatedSceneType: OKScene.Type

    init(sceneType: OKScene.Type) {
        self.associatedSceneType = sceneType
        super.init()
    }

    // Provide some method or property to fetch the desired scene type without overriding the associatedSceneClass directly
    func getSceneType() -> OKScene.Type {
        return associatedSceneType
    }
}

class GameState: BaseConstruct {
    let associatedScene: Scene
    let associatedSwiftUIView: Any?

    init(scene: Scene, swiftUIView: Any? = nil) {
        self.associatedScene = scene
        self.associatedSwiftUIView = swiftUIView
    }
    
    func instantiateOKGameState() -> OKGameState {
        return CustomOKGameState(sceneType: type(of: associatedScene.okScene))
    }
}
