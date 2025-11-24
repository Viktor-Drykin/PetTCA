//
//  ContentView.swift
//  PetTCA
//
//  Created by Viktor Drykin on 23.11.2025.
//

import SwiftUI
import ComposableArchitecture

struct ContentView: View {
    var body: some View {
        NavigationStack {
            NavigationLink("Counter") {
                CounterView(
                    store: Store(
                        initialState: CounterReducer.State(), reducer: { CounterReducer() }
                    )
                )
            }
        }
    }
}

#Preview {
    ContentView()
}
