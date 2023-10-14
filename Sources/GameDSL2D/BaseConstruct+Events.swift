//
//  BaseConstruct+Events.swift
//  
//
//  Created by P. Mark Anderson on 10/12/23.
//

import Foundation

extension BaseConstruct {
    
    // For Notification.Name
    @discardableResult
    func onEvent(_ name: Notification.Name, perform closure: @escaping (BaseConstruct, EventInfo?) -> Void) -> Self {
        return onEvent(name.rawValue, perform: closure)
    }
    
    // For String
    func onEvent(_ name: String, perform closure: @escaping (BaseConstruct, EventInfo?) -> Void) -> Self {
        EventManager.shared.subscribe(self, to: name, using: closure)
        return self
    }
    
    func storeToken(_ token: NSObjectProtocol, for name: String) {
        eventTokens[name] = token
    }

    // For Notification.Name
    func emit(_ name: Notification.Name, target: BaseConstruct? = nil, userInfo: EventInfo? = nil) {
        EventManager.shared.postEvent(name, target: target, userInfo: userInfo)
    }
    
    // For String
    func emit(_ name: String, target: BaseConstruct? = nil, userInfo: EventInfo? = nil) {
        EventManager.shared.postEvent(name, target: target, userInfo: userInfo)
    }
}
