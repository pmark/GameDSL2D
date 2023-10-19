//
//  State.swift
//  
//
//  Created by P. Mark Anderson on 8/27/23.
//

import Foundation

public class State: BaseConstruct, Equatable {
    let key: AnyKey
    var onEnterAction: ((State) -> Void)?
    var onExitAction: ((State) -> Void)?
    var componentsToAddOnEntry: [ComponentInitializer] = []
    var componentTypesToRemoveOnExit: [ComponentType.Type] = []
    
    init(key: StateKey) {
        self.key = AnyKey(key)
        super.init(name: key.stringValue)
    }
    
    init(key: AnyKey) {
        self.key = key
        super.init(name: key.stringValue)
    }
    
    public static func == (lhs: State, rhs: State) -> Bool {
        lhs.key == rhs.key
    }

    func didEnter(from previousStateKey: AnyKey? = nil, action: @escaping (State) -> Void) -> Self {
        if let key = previousStateKey, key == self.key {
            self.onEnterAction = action
        } else if previousStateKey == nil {
            self.onEnterAction = action
        }
        return self
    }
    
    func willExit(to nextStateKey: AnyKey? = nil, action: @escaping (State) -> Void) -> Self {
        if let key = nextStateKey, key == self.key {
            self.onExitAction = action
        } else if nextStateKey == nil {
            self.onExitAction = action
        }
        return self
    }
    
    @discardableResult
    func componentsToAddOnEntry(_ batch: @escaping () -> [ComponentType]) -> Self {
        self.componentsToAddOnEntry.append(ComponentInitializer(multi: batch))
        return self
    }
    
    @discardableResult
    func componentsToAddOnEntry(_ componentTypes: ComponentType.Type...) -> Self {
        for type in componentTypes {
            let ci = ComponentInitializer(type: type)
            self.componentsToAddOnEntry.append(ci)
        }
        return self
    }
    
    @discardableResult
    func componentTypesToRemoveOnExit(_ componentTypes: ComponentType.Type...) -> Self {
        self.componentTypesToRemoveOnExit += componentTypes
        return self
    }

    func triggerOnEnter(from previousStateKey: AnyKey? = nil) {
        // Handle adding components
        // What about Scenario, Scene, Level, etc?
        // Maybe any construct can have entities added as children?
        if let entity = parent as? Entity {
            let components = componentsToAddOnEntry.flatMap { ci in
                ci.instantiate()
            }
            entity.okEntity.addComponents(components)
        }
        
        onEnterAction?(self)
    }
    
    func triggerOnExit(to nextStateKey: AnyKey? = nil) {
        // Handle removing components
        if let entity = parent as? Entity {
            entity.okEntity.removeComponents(ofTypes: componentTypesToRemoveOnExit)
        }
        
        onExitAction?(self)
    }
}

public enum StateKey: String, KeyProtocol {
    case initializing
    case active
    case inactive
    case finished
}
