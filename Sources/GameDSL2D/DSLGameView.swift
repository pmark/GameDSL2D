//
//  DSLGameView.swift
//  
//
//  Created by P. Mark Anderson on 9/26/23.
//
/**
 Usage in SwiftUI app:
 
 struct ContentView: View {
     var body: some View {
         DSLGameView(game:
             Game() {
                 Scene(key: .playing) {
                     Entity(name: "Player") {
                         Components {[
                             TestComponent()
                         ]}
                     }
                 }
                 GameState(.playing)
             }
         )
     }
 }

 */

import SwiftUI
import OctopusKit

public struct DSLGameView: View {
    @StateObject public var game: Game
    
    public init(_ game: Game) {
        _game = StateObject(wrappedValue: game)
    }
    
    public var body: some View {
        OKContainerView<DSLGameCoordinator, OctopusViewController>()
            .environmentObject(game.coordinator)
            .onAppear {
                game.coordinator.enterInitialState()
            }
    }
}
