//
//  Trigger.swift
//  
//
//  Created by P. Mark Anderson on 8/27/23.
//

import Foundation

protocol AnyTrigger {
    var event: GameEventKey? { get }
    func check(using data: GameData) -> Bool
    func evaluate(using data: GameData)
}

class Trigger<T: GameData>: BaseConstruct, Activatable, AnyTrigger {
    let condition: (T) -> Bool
    let event: GameEventKey?
    let action: ((T) -> Void)?
    
    init(event: GameEventKey?, action: ((T) -> Void)? = nil, condition: @escaping (T) -> Bool) {
        assert(event != nil || action != nil, "Either event or action must be specified.")
        self.condition = condition
        self.event = event
        self.action = action
        super.init()  // call the initializer of BaseConstruct
    }
    
//    init(condition: @escaping (T) -> Bool, event: GameEventKey?, action: ((T) -> Void)? = nil) {
//        assert(event != nil || action != nil, "Either event or action must be specified.")
//        self.condition = condition
//        self.event = event
//        self.action = action
//        super.init()  // call the initializer of BaseConstruct
//    }
    
    // Attach trigger to the GameData of its parent construct
    override func didSetParent() {
        parent?.data?.triggers.append(self)
    }

    func check(using data: GameData) -> Bool {
        return condition(data as! T)
    }
    
    func evaluate(using data: GameData) {
        if check(using: data) {
            if let event = event {
                // Signal the event to any observing systems
                // This can be achieved by various means, such as NotificationCenter, Combine Publishers, etc.
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: event.rawValue), object: nil)
                print("Triggered event: \(event)")
            }
            action?(data as! T)
        }
    }
    
//    override func activate() {
//        // Trigger-specific activation logic can go here if necessary
//    }
}

