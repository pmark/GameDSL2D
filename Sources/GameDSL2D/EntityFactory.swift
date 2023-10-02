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
    private var entityRegistry: [AnyKey: [String: Entity]] = [:]

    private init() {}
    
    public func register(type: EntityType, name: String, entity: Entity) {
        register(type: AnyKey(type), name: name, entity: entity)
    }
    
    public func register(type: AnyKey, name: String, entity: Entity) {
        if entityRegistry[type] == nil {
            entityRegistry[type] = [:]
        }
        entityRegistry[type]?[name] = entity
    }

    public func create(type: AnyKey, name: String? = "") -> OKEntity? {
        guard let name = name,
              let rootEntityTemplate = entityRegistry[type],
              let entityTemplate = rootEntityTemplate[name] else {
            return nil
        }
        return entityTemplate.createOKEntity()
    }
}
