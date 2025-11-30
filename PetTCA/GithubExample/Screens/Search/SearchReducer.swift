//
//  SearchReducer.swift
//  PetTCA
//
//  Created by Viktor Drykin on 28.11.2025.
//

import ComposableArchitecture
import SwiftUI

@Reducer
struct SearchReducer {
    
    @Reducer
    enum Destination {
      case repositories(RepositoryListFeature)
    }
    
    @ObservableState
    struct State {//: Equatable {
        var userName: String = ""
        var path = StackState<Destination.State>()
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case didTapSearch
        case path(StackActionOf<Destination>)
    }
    
    var body: some Reducer<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .binding(\.userName):
                return .none
            case .didTapSearch:
                print("didTapSearch")
                return .none
            default:
                return .none
            }
        }
        .forEach(\.path, action: \.path)
    }
}
