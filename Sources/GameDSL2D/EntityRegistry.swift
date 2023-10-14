//
//  EntityRegistry.swift
//
//
//  Created by P. Mark Anderson on 9/28/23.
//

import Foundation
import OctopusKit

public class EntityRegistry {
    static let shared = EntityRegistry()
    
    private typealias EntityDictionary = [String: Entity]
    private var entityRegistry: [AnyKey: EntityDictionary] = [:]
    
    private init() {}
    
    public func register(type: EntityType, name: String, entity: Entity) {
        register(type: AnyKey(type), name: name, entity: entity)
    }
    
    public func register(type: AnyKey, name: String, entity: Entity) {
        if entityRegistry[type] == nil {
            entityRegistry[type] = EntityDictionary()
        }
        entityRegistry[type]?[name] = entity
    }
    
    public func findEntity(ofType type: EntityType, withName name: String? = "") -> Entity? {
        return self.findEntity(ofType: AnyKey(type), withName: name)
    }

    public func findEntity(ofType type: AnyKey, withName name: String? = nil) -> Entity? {
        // Default name to empty string if none provided
        let entityName = name ?? ""
        
        // Check if the entity type exists in the registry
        if let group = entityRegistry[type] {
            
            // Search for the entity by name within the group
            if let entity = group[entityName] {
                return entity
            } else {
                // Log the event of not finding an entity with that name
                print("Warning: No entity found with type \(type) and name \(entityName).")
                return nil
            }
        } else {
            // Log the event of not finding an entity group of that type
            print("Warning: No entity group found for type \(type).")
            return nil
        }
    }

    /*
    public func create(type: AnyKey, name: String? = nil) -> OKEntity? {
        guard let rootEntityTemplate = entityRegistry[type] else {
            return nil
        }
        let lookupName = name ?? ""
        guard let entityTemplate = rootEntityTemplate[lookupName] else {
            return nil
        }
        return entityTemplate.createOKEntity() // Ensure this is a deep copy
    }
    */

}
