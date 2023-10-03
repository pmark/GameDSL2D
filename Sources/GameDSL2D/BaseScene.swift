//
//  BaseScene.swift
//  
//
//  Created by P. Mark Anderson on 8/31/23.
//

import Foundation
import OctopusKit
import GameplayKit

public class BaseScene: OctopusScene {
    
    var sceneManager: SceneManager?
    var componentTypes: [GKComponent.Type] = []
    var scenarios: [Scenario] = []
    
    public required init(size: CGSize) {
        super.init(size: size)
        backgroundColor = .orange
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func createComponentSystems() -> [GKComponent.Type] {
        return componentTypes
    }
    
    public override func sceneDidLoad() {
        print("\n\nBaseScene did load\n\n")
    }
    
//    public override func prepareContents() {
        // This may not be necessary since Scene activation adds entities
//    }
}
