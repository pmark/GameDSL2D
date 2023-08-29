//
//  State.swift
//  
//
//  Created by P. Mark Anderson on 8/27/23.
//

import Foundation

enum StateKey: String {
    case state1, state2 // ... more states
}

class State: BaseConstruct {
    let key: StateKey
    var onEnterAction: ((State) -> Void)?
    var onExitAction: ((State) -> Void)?
    
    init(_ key: StateKey) {
        self.key = key
        super.init(name: key.rawValue)
    }
    
    func onEnter(_ action: @escaping (State) -> Void) -> Self {
        self.onEnterAction = action
        return self
    }
    
    func onExit(_ action: @escaping (State) -> Void) -> Self {
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

