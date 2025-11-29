//
//  TwoCountersView.swift
//  PetTCA
//
//  Created by Viktor Drykin on 27.11.2025.
//

import SwiftUI
import ComposableArchitecture

@Reducer
struct TwoCounters {
    
    @ObservableState
    struct State: Equatable {
        var counter1: CounterReducer.CounterState = .init()
        var counter2: CounterReducer.CounterState = .init()
    }
    
    enum Action {
        case counter1(CounterReducer.CounterAction)
        case counter2(CounterReducer.CounterAction)
    }
    
    var body: some Reducer<State, Action> {
      Scope(state: \.counter1, action: \.counter1) {
          CounterReducer()
      }
      Scope(state: \.counter2, action: \.counter2) {
          CounterReducer()
      }
    }
}

struct TwoCountersView: View {
    private let store: StoreOf<TwoCounters>
    
    init(store: StoreOf<TwoCounters>) {
        self.store = store
    }
    
    var body: some View {
        VStack {
            HStack {
              Text("Counter 1")
              Spacer()
              CounterView(store: store.scope(state: \.counter1, action: \.counter1))
            }
            HStack {
              Text("Counter 2")
              Spacer()
              CounterView(store: store.scope(state: \.counter2, action: \.counter2))
            }
        }
        .padding()
    }
}

#Preview {
    TwoCountersView(
        store: Store(
            initialState: TwoCounters.State(), reducer: { TwoCounters() }
        )
    )
}
