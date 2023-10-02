//
//  ContentView.swift
//  ExampleGameDSL2D
//
//  Created by P. Mark Anderson on 9/21/23.
//

import SwiftUI
import OctopusKit
import GameDSL2D

struct ContentView: View {
    var body: some View {
        DSLGameView(game)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

let game = Game {
    Scene(key: .playing) {
        Entity.player
    }
    GameState(.playing)
}
