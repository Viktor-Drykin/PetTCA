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
        TabView {
            Tab("Github", systemImage: "gear") {
                githubExample
            }
            Tab("TCA examples", systemImage: "house") {
                tcaExamples
            }
        }
    }
    
    private var githubExample: some View {
        SearchView(store: .init(initialState: .init(), reducer: { SearchReducer() } ))
    }
    
    private var tcaExamples: some View {
        NavigationStack {
            List {
                NavigationLink("Counter") {
                    CounterView(
                        store: Store(
                            initialState: CounterReducer.State(), reducer: { CounterReducer() }
                        )
                    )
                }
                NavigationLink("Two Counters") {
                    TwoCountersView(
                        store: Store(
                            initialState: TwoCounters.State(), reducer: { TwoCounters() }
                        )
                    )
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
