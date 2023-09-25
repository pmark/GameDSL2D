//
//  ContentView.swift
//  ExampleGameDSL2D
//
//  Created by P. Mark Anderson on 9/21/23.
//

import SwiftUI
import OctopusKit

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
