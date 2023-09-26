//
//  State.swift
//  
//
//  Created by P. Mark Anderson on 8/27/23.
//

import Foundation

enum DSLStateKey: String {
    case initializing
    case active
    case inactive
    case finished
}

public class State: BaseConstruct {
    let key: DSLStateKey
    var onEnterAction: ((State) -> Void)?
    var onExitAction: ((State) -> Void)?
    
    init(_ key: DSLStateKey) {
        self.key = key
        super.init(name: key.rawValue)
    }
    
    func didEnter(from previousState: DSLStateKey? = nil, action: @escaping (State) -> Void) -> Self {
        self.onEnterAction = action
        return self
    }
    
    func willExit(to nextState: DSLStateKey? = nil, action: @escaping (State) -> Void) -> Self {
        self.onExitAction = action
        return self
    }
    
    // This method can be used internally to trigger the onEnter action
    func triggerOnEnter() {
        onEnterAction?(self)
    }
    
    // This method can be used internally to trigger the onExit action
    func triggerOnExit() {
        onExitAction?(self)
    }
}

