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
    
    public override func prepareContents() {
        // Your implementation here, which will use the elements declared within the DSL.
        // You'd typically iterate over the entities and components you have defined in your DSL
        // and add them to the scene.
        
//        sceneManager?.populateScene(self)
        
        for scenario in scenarios {
            for entity in scenario.entities {
                for component in entity.components {
                    entity.okEntity.addComponent(component)
                }
                addEntity(entity.okEntity)
            }
        }
    }
}
