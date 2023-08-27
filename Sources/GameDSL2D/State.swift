//
//  State.swift
//  
//
//  Created by P. Mark Anderson on 8/27/23.
//

import Foundation

enum StateName: String {
    case state1, state2 // ... more states
}

struct State {
    let name: StateName
    var onEnter: (() -> Void)?
    var onExit: (() -> Void)?

    init(_ name: StateName, onEnter: (() -> Void)? = nil, onExit: (() -> Void)? = nil) {
        self.name = name
        self.onEnter = onEnter
        self.onExit = onExit
    }
}
