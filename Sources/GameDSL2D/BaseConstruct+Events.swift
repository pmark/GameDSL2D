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
    public func onEvent(_ name: Notification.Name, perform closure: @escaping (BaseConstruct, EventInfo?) -> Void) -> Self {
        return onEvent(name.rawValue, perform: closure)
    }
    
    // For String
    public func onEvent(_ name: String, perform closure: @escaping (BaseConstruct, EventInfo?) -> Void) -> Self {
        EventManager.shared.subscribe(self, to: name, using: closure)
        return self
    }
    
    public func storeToken(_ token: NSObjectProtocol, for name: String) {
        eventTokens[name] = token
    }

    // For Notification.Name
    public func emit(_ name: Notification.Name, target: BaseConstruct? = nil, userInfo: EventInfo? = nil) {
        EventManager.shared.postEvent(name, target: target, userInfo: userInfo)
    }
    
    // For String
    public func emit(_ name: String, target: BaseConstruct? = nil, userInfo: EventInfo? = nil) {
        EventManager.shared.postEvent(name, target: target, userInfo: userInfo)
    }
    
    public func unsubscribe(from name: String) {
        if let token = eventTokens[name] {
            NotificationCenter.default.removeObserver(token)
        }
    }
}
