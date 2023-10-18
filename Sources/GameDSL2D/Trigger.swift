//
//  Trigger.swift
//  

import Foundation

protocol AnyTrigger {
    var event: AnyKey? { get }
    func check(using data: GameData) -> Bool
    func evaluate(using data: GameData)
}

public class Trigger<T: GameData>: BaseConstruct, Activatable, AnyTrigger {
    let condition: (T) -> Bool
    let event: AnyKey?
    let action: ((T) -> Void)?
    
    convenience init(emit event: GameEventKey?, perform action: ((T) -> Void)? = nil, when condition: @escaping (T) -> Bool) {
        if let gameEvent = event {
            self.init(emit: AnyKey(gameEvent), perform: action, when: condition)
        } else {
            self.init(perform: action, when: condition)
        }
    }
    
    init(emit event: AnyKey? = nil, perform action: ((T) -> Void)? = nil, when condition: @escaping (T) -> Bool) {
        assert(event != nil || action != nil, "Either event or action must be specified.")
        self.condition = condition
        self.event = event
        self.action = action
        super.init(name: "Trigger \(event?.stringValue ?? "")")  // call the initializer of BaseConstruct
    }
    
    // Attach trigger to the GameData of its parent construct
    public override func didSetParent() {
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
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: event.stringValue), object: nil)
                print("Triggered event: \(event)")
            }
            action?(data as! T)
        }
    }
    
//    override func activate() {
//        // Trigger-specific activation logic can go here if necessary
//    }
}

