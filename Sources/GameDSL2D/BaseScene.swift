//
//  File.swift
//  
//
//  Created by P. Mark Anderson on 8/31/23.
//

import Foundation
import OctopusKit
import GameplayKit

public class BaseScene: OKScene {
    
    var sceneManager: SceneManager?
    var componentTypes: [OKComponent.Type] = []
    var scenarios: [Scenario] = []
    
    public override func createComponentSystems() -> [GKComponent.Type] {
        return componentTypes
    }
    
//    public override func prepareContents() {
        // This may not be necessary since Scene activation adds entities
//    }
}
