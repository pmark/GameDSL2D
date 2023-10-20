//
//  State.swift
//  
//
//  Created by P. Mark Anderson on 8/27/23.
//

import Foundation
import OctopusKit

public class State: BaseConstruct, Equatable {
    let key: AnyKey
    var onEnterAction: ((State) -> Void)?
    var onExitAction: ((State) -> Void)?
    var onUpdateAction: ((TimeInterval) -> Void)?
    var componentsToAddOnEntry: [ComponentInitializer] = []
    var componentTypesToRemoveOnExit: [ComponentType.Type] = []
    var _gkState: BaseState? = nil
    
    init(key: AnyKey) {
        self.key = key
        super.init(name: key.stringValue)
    }

    public static func == (lhs: State, rhs: State) -> Bool {
        lhs.key == rhs.key
    }

    public var gkState: BaseState {
        if let gkState = _gkState {
            return gkState
        }
        
        guard let parent = self.parent else {
            assert(false, "State requires a parent")
        }
        
        if let entity = parent as? Entity {
            let bs = BaseState(entity: entity.okEntity)
            _gkState = bs
            return bs
        } else if let stateMachineEntity = parent.firstEntity(withIdentifier: EntityIdentifier(type: .stateMachine)) {
            let bs = BaseState(entity: stateMachineEntity.okEntity)
            _gkState = bs
            return bs
        } else if var autoEntityParent = parent as? AutoEntityCreatable {
            // If parent can create entities automatically, do so.
            // We're creating an entity to contain any and all states associated with the parent construct.
            let newEntity = Entity(type: .stateMachine)
            autoEntityParent.addAutoCreatedEntity(newEntity)

            // Create a BaseState for this new Entity
            let bs = BaseState(entity: newEntity.okEntity)
            _gkState = bs
            return bs
        } else {
            // Handle case where parent is neither an Entity nor capable of creating entities
            assert(false, "State requires a valid parent")
        }
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
    
    public func onUpdate(_ action: @escaping (TimeInterval) -> Void) -> Self {
        self.onUpdateAction = action
        return self
    }

    public func triggerOnUpdate(deltaTime: TimeInterval) {
        onUpdateAction?(deltaTime)
    }
}

public class BaseState: OKEntityState {
    weak var state: State?
    
    public func didEnter(from previousState: AnyKey?) {
        if let previousState = previousState {
            state?.triggerOnEnter(from: previousState)
        } else {
            state?.triggerOnEnter()
        }
    }
    
    public func willExit(to nextState: AnyKey) {
        state?.triggerOnExit(to: nextState)
    }
    
    public override func update(deltaTime seconds: TimeInterval) {
        state?.triggerOnUpdate(deltaTime: seconds)
    }
}
