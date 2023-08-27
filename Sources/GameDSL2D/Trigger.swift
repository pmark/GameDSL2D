//
//  Trigger.swift
//  
//
//  Created by P. Mark Anderson on 8/27/23.
//

import Foundation
import Combine

import Combine

protocol ObservableData: ObservableObject {
    var eventPublisher: GameEventKey? { get set }
}

class Trigger<Data: ObservableData> {
    var condition: (Data) -> Bool
    var event: GameEventKey?
    var action: ((Data) -> Void)?
    private var cancellable: AnyCancellable?
    
    init(condition: @escaping (Data) -> Bool, event: GameEventKey?, action: ((Data) -> Void)? = nil) {
        self.condition = condition
        self.event = event
        self.action = action
    }

    func evaluate(using data: Data) {
        guard let eventKey = data.eventPublisher else { return }
        if condition(data) {
            if let action = self.action {
                action(data)
            } else if let event = self.event, event == eventKey {
                // Handle the event
                print("Event triggered: \(event)")
            }
        }
    }

    // TODO: figure this out
//    func bind(to data: Data) {
//        cancellable = data.$eventPublisher.sink { [weak self] _ in
//            self?.evaluate(using: data)
//        }
//    }
}
