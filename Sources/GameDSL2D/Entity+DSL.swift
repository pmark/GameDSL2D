//
//  File.swift
//  
//
//  Created by P. Mark Anderson on 7/29/23.
//

import GameplayKit

public extension Entity {
    convenience init(_ name: String? = nil, @EntityBuilder _ content: () -> [GameElement]) {
        self.init(name)
        self.elements = content()
        
        elements.forEach { element in
            if let component = element as? Component {
                addComponent(component)
            }
        }
    }
}
