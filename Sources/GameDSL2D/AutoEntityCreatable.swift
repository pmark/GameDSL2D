//
//  AutoEntityCreatable.swift
//  
//
//  Created by P. Mark Anderson on 10/19/23.
//

import Foundation

// Protocol definition
public protocol AutoEntityCreatable {
    var autoCreatedEntities: [Entity] { get set }
}

// Default implementations
public extension AutoEntityCreatable {
    
    // Function to add a new Entity
    mutating func addAutoCreatedEntity(_ entity: Entity) {
        autoCreatedEntities.append(entity)
    }
    
    // Function to remove an Entity by reference
    mutating func removeAutoCreatedEntity(_ entity: Entity) {
        if let index = autoCreatedEntities.firstIndex(where: { $0 === entity }) {
            autoCreatedEntities.remove(at: index)
        }
    }
    
    // Function to remove an Entity by key
    mutating func removeAutoCreatedEntity(byIdentifier identifier: EntityIdentifier) {
        autoCreatedEntities.removeAll(where: { $0.identifier == identifier })
    }
    
    // Function to find an Entity by key
    func findAutoCreatedEntity(byIdentifier identifier: EntityIdentifier) -> Entity? {
        return autoCreatedEntities.first(where: { $0.identifier == identifier })
    }
}
