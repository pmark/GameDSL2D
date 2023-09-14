//
//  OKComponentWrapper.swift
//  
//
//  Created by P. Mark Anderson on 9/13/23.
//

import Foundation
import OctopusKit
import GameplayKit

class OKComponentWrapper: OKComponent {
    
    private let gkComponent: GKComponent
    
    init(_ gkComponent: GKComponent) {
        print("\n\nwrapping GKComponent")
        self.gkComponent = gkComponent
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Example of a method to demonstrate how wrapping could work:
    override func update(deltaTime seconds: TimeInterval) {
        // Redirect to GKComponent's update functionality, if necessary
        gkComponent.update(deltaTime: seconds)
    }
    
    // TODO: add any other necessary methods and properties to ensure compatibility between GKComponent and OKComponent.
    
}
