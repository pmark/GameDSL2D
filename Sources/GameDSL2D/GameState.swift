//
//  File.swift
//  
//
//  Created by P. Mark Anderson on 9/8/23.
//

import OctopusKit
import SwiftUI

public class GameState: OKGameState {
    let identifier: GameIdentifier
    let sceneIdentifier: GameIdentifier?
//    let sceneFileName: String? // TODO: For scenes that should be loaded from .sks files
    
    public init(_ identifier: GameIdentifier, sceneIdentifier: GameIdentifier? = nil) {
        self.identifier = identifier
        self.sceneIdentifier = sceneIdentifier
        super.init()
        self.associatedSceneClass = BaseScene.self
    }

    public convenience init<V: View>(_ identifier: GameIdentifier, sceneIdentifier: GameIdentifier? = nil, view: V) {
        self.init(identifier, sceneIdentifier: sceneIdentifier)
        self.associatedSceneClass = BaseScene.self
        self.associatedSwiftUIView = AnyView(view)
    }
}

public enum GameIdentifier: String, RawRepresentable {
    case launch
    case mainMenu
    case lobby
    case levelSelect
    case settings
    case playing
    case paused
    case failure
    case success
    case minorTransition
    case majorTransition
    case complete
}
