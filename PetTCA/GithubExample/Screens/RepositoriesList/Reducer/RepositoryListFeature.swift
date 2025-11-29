//
//  RepositoryListFeature.swift
//  PetTCA
//
//  Created by Viktor Drykin on 28.11.2025.
//

import ComposableArchitecture

@Reducer
struct RepositoryListFeature {
    
    @ObservableState
    struct State {
        var repositories: [Repository] = []
//        case loading
//        case loaded([Repository])
//        case failed(message: String)
    }
    
    enum Action {
        case requestRepositoryList
        case showError(message: String)
        case showRepository(list: [Repository])
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .requestRepositoryList:
                print("requestRepositoryList:")
                return .none
            case .showError(let errorMessage):
                print("showError")
                return .none
            case .showRepository(let repositoryList):
                print("showRepository")
                return .none
            }
        }
    }
}
