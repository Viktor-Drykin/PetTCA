//
//  CounterView.swift
//  PetTCA
//
//  Created by Viktor Drykin on 24.11.2025.
//

import SwiftUI
import ComposableArchitecture

struct CounterView: View {
    
    private let store: StoreOf<CounterReducer>
    
    init(store: StoreOf<CounterReducer>) {
        self.store = store
    }
    
    var body: some View {
        VStack {
            Button {
                store.send(.increase)
            } label: {
                Text("Increase")
                    .padding()
            }
            Text("Counter: \(store.counter)")
            Button {
                store.send(.decrease)
            } label: {
                Text("Decrease")
                    .padding()
            }

        }
        .padding()
    }
}

@Reducer
struct CounterReducer {
    
    @ObservableState
    struct CounterState: Equatable {
        var counter = 0
    }

    enum CounterAction: Equatable {
        case increase
        case decrease
    }
    
    func reduce(into state: inout CounterState, action: CounterAction) -> Effect<CounterAction> {
        switch action {
        case .increase:
            state.counter += 1
            return .none
        case .decrease:
            state.counter -= 1
            return .none
        }
    }
}

#Preview {
    CounterView(
        store: Store(
            initialState: CounterReducer.State(), reducer: { CounterReducer() }
        )
    )
}

