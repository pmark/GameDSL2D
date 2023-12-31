//
//  EventManager.swift
//  
//
//  Created by P. Mark Anderson on 10/12/23.
//

import Foundation

public typealias EventInfo = [AnyHashable: Any]

public class EventManager {
    
    static let shared = EventManager()
    
    private var lastEventTimestamps: [String: TimeInterval] = [:]

    private init() {}

    
    // For Notification.Name
    public func postEvent(_ name: Notification.Name, target: BaseConstruct? = nil, userInfo: EventInfo?) {
        NotificationCenter.default.post(name: name, object: target, userInfo: userInfo)
    }

    // For String
    public func postEvent(_ name: String, target: BaseConstruct? = nil, userInfo: EventInfo?) {
        postEvent(Notification.Name(rawValue: name), target: target, userInfo: userInfo)
    }
    
    // For Notification.Name
    public func subscribe(_ construct: BaseConstruct, to name: Notification.Name, using closure: @escaping (BaseConstruct, EventInfo?) -> Void) {
        subscribe(construct, to: name.rawValue, using: closure)
    }
    
    // For String
    public func subscribe(_ construct: BaseConstruct, to name: String, using closure: @escaping (BaseConstruct, EventInfo?) -> Void) {
        let token = NotificationCenter.default.addObserver(forName: Notification.Name(name), object: nil, queue: nil) { notification in
            if let target = notification.object as? BaseConstruct {
                if target === construct && construct.isActive {
                    closure(construct, notification.userInfo)
                }
            } else if construct.isActive {
                closure(construct, notification.userInfo)
            }
        }
        construct.storeToken(token, for: name)
    }
}
