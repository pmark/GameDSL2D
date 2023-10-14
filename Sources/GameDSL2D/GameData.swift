//
//  GameData.swift
//  
//
//  Created by P. Mark Anderson on 8/27/23.
//

import Foundation
import Combine

// Base GameData with generic properties
/*
 Generic usage:
 
 let player = Entity {
     GameData([
         "position": [0, 0],
         "health": 100
     ])
     .set("weapon", value: "Sword") // sets a String
     Trigger { gameData in
         // Gets type-safe values
         let position: [Int]? = gameData.get("position")
         let weapon: String? = gameData.get("weapon")
         // ...
     }
     // ...
 }
 
*/
public class GameData: ObservableObject {
    var id: UUID = UUID()
    var data: [String: Any] = [:]
    var metadata: [String: Any] = [:]
    var timestamp: Date = Date()
    var tags: Set<String> = []
    
    @Published var triggers: [AnyTrigger] = []
    
    
    init(_ initialData: [String: Any]) {
        self.data = initialData
    }
   
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
    
    // Generic function to set value
    func set<T>(_ key: String, value: T) {
        data[key] = value
    }
    
    // Generic function to get a typed value
    func get<T>(_ key: String) -> T? {
        return data[key] as? T
    }
    
}
