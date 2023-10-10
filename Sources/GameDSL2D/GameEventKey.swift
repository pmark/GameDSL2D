//
//  GameEventKey.swift
//  
//
//  Created by P. Mark Anderson on 8/27/23.
//

import Foundation

public enum GameEventKey: String, KeyProtocol {
    case gameLoaded
    case gameStarted
    case gameOver
    case gameCompleted
    case levelStarted
    case levelCompleted
    case levelFailed
    case scenarioStarted
    case scenarioCompleted
    case scenarioFailed
}
