//
//  File.swift
//  
//
//  Created by P. Mark Anderson on 9/9/23.
//

import Foundation
import GameplayKit

typealias ComponentSystem = GKComponentSystem

class SystemsManager {
    private var registeredSystems: [ObjectIdentifier: ComponentSystem] = [:]
    
    func registerSystem<T: ComponentType>(for componentType: T.Type) {
//        let system = /* ... create or fetch the system for the component ... */
//        registeredSystems[ObjectIdentifier(componentType)] = system
    }
    
    func unregisterSystem<T: ComponentType>(for componentType: T.Type) {
        registeredSystems.removeValue(forKey: ObjectIdentifier(componentType))
    }
    
    // Methods to handle system updates, etc.
}

class ComponentRegistryManager {
    // A dictionary to store component types and their count
    private var componentUsageCounts: [ObjectIdentifier: Int] = [:]
    
    // A reference to the systems manager to register/unregister systems
    private let systemsManager: SystemsManager
    
    init(systemsManager: SystemsManager) {
        self.systemsManager = systemsManager
    }
    
    func registerComponent<T: ComponentType>(_ componentType: T.Type) {
        let id = ObjectIdentifier(componentType)
        let currentCount = componentUsageCounts[id, default: 0]
        
        // Update count and register system if this is the first usage
        componentUsageCounts[id] = currentCount + 1
        if currentCount == 0 {
            systemsManager.registerSystem(for: componentType)
        }
    }
    
    func unregisterComponent<T: ComponentType>(_ componentType: T.Type) {
        let id = ObjectIdentifier(componentType)
        if let currentCount = componentUsageCounts[id], currentCount > 1 {
            componentUsageCounts[id] = currentCount - 1
        } else {
            componentUsageCounts.removeValue(forKey: id)
            systemsManager.unregisterSystem(for: componentType)
        }
    }
}


class ComponentSynchronizationManager {
    private let registryManager: ComponentRegistryManager
    
    init(registryManager: ComponentRegistryManager) {
        self.registryManager = registryManager
    }
    
    func entityAddedComponent<T: ComponentType>(_ component: T) {
        registryManager.registerComponent(T.self)
    }
    
    func entityRemovedComponent<T: ComponentType>(_ component: T) {
        registryManager.unregisterComponent(T.self)
    }
    
    // This can also handle modifiers as per previous discussions
}
