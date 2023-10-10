//
//  EntityFactory.swift
//  
//
//  Created by P. Mark Anderson on 9/28/23.
//

import Foundation
import OctopusKit

public class EntityFactory {
    static let shared = EntityFactory()
    
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
    
    public func findEntity(ofType type: EntityType, withName name: String? = nil) -> Entity? {
        return self.findEntity(ofType: AnyKey(type), withName: name)
    }

    public func findEntity(ofType type: AnyKey, withName name: String? = nil) -> Entity? {
        if let group = entityRegistry[type] {
            if let name = name {
                return group[name]
            }
            
            if let first = group.keys.first {
                return group[first]
            }
        }
        return nil
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
