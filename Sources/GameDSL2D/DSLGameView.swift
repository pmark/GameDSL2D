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
         DSLGameView {
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
         }
     }
 }

 */

import SwiftUI
import OctopusKit

struct DSLGameView: View {
    @StateObject var game: Game
    
    init(_ game: Game) {
        _game = StateObject(wrappedValue: game)
    }
    
    var body: some View {
        OKContainerView()
            .environmentObject(game.coordinator)
            .statusBar(hidden: true)
    }
}
