//
//  GameData.swift
//  
//
//  Created by P. Mark Anderson on 8/27/23.
//

import Foundation
import Combine

// Base GameData with generic properties
class GameData: ObservableObject {
    var id: UUID = UUID()
    var metadata: [String: Any] = [:]
    var timestamp: Date = Date()
    var tags: Set<String> = []
    
    @Published var triggers: [AnyTrigger] = []
    
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        $triggers
            .sink { triggers in
                triggers.forEach { trigger in
                    trigger.evaluate(using: self)
                }
            }
            .store(in: &cancellables)
    }
}
