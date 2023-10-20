//
//  Activatable.swift
//  
//
//  Created by P. Mark Anderson on 10/19/23.
//

import Foundation

protocol Activatable {
    var isActive: Bool { get set }
    func activate()
    func deactivate()
}
