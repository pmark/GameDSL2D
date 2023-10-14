//
//  EventManager.swift
//  
//
//  Created by P. Mark Anderson on 10/12/23.
//

import Foundation

typealias EventInfo = [AnyHashable: Any]

class EventManager {
    
    static let shared = EventManager()
    
    private var lastEventTimestamps: [String: TimeInterval] = [:]

    private init() {}

    
    // For Notification.Name
    func postEvent(_ name: Notification.Name, target: BaseConstruct?, userInfo: EventInfo?) {
        NotificationCenter.default.post(name: name, object: target, userInfo: userInfo)
    }

    // For String
    func postEvent(_ name: String, target: BaseConstruct?, userInfo: EventInfo?) {
        postEvent(Notification.Name(rawValue: name), target: target, userInfo: userInfo)
    }
    
    // For Notification.Name
    func subscribe(_ construct: BaseConstruct, to name: Notification.Name, using closure: @escaping (BaseConstruct, EventInfo?) -> Void) {
        subscribe(construct, to: name.rawValue, using: closure)
    }
    
    // For String
    func subscribe(_ construct: BaseConstruct, to name: String, using closure: @escaping (BaseConstruct, EventInfo?) -> Void) {
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
