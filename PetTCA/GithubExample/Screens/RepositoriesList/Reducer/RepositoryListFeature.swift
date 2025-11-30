//
//  RepositoryListFeature.swift
//  PetTCA
//
//  Created by Viktor Drykin on 28.11.2025.
//

import ComposableArchitecture

@Reducer
struct RepositoryListFeature {
    
    @Dependency(\.repositoryService) var repositoryService
    
    enum Constant {
        static let noRepos = "There are no repositories"
        static let invalidStatusCodeError = "Error: invalidStatusCode"
        static let failedToDecodeError = "Error: failedToDecode"
        static let incorrectUserNameError = "Error: incorrectUserName"
        static let unknownError = "Error: something went wrong"
    }
    
    @ObservableState
    struct State: Equatable {
        
        enum RequestState {
            case initial
            case loading
            case loaded([Repository])
            case failed(message: String)
        }
        
        var userName: String = ""
        var requestState: RequestState = .initial
    }
    
    enum Action {
        case onAppear
        case showError(message: String)
        case showRepository(list: [Repository])
    }
    
    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                state.requestState = .loading
                return requestRepository(userName: state.userName)
            case .showError(let errorMessage):
                state.requestState = .failed(message: errorMessage)
                return .none
            case .showRepository(let repositoryList):
                state.requestState = .loaded(repositoryList)
                return .none
            }
        }
    }
    
    private func requestRepository(userName: String) -> Effect<Action> {
        return .run { send in
            do {
                let repositories = try await repositoryService.fetchRepos(with: userName)
                let list: [Repository] = repositories.map { Repository(dto: $0) }
                await send(.showRepository(list: list))
            } catch {
                let errorMessage = await errorMessage(for: error)
                await send(.showError(message: errorMessage))
            }
        }
    }
    
    private func errorMessage(for error: Error) -> String {
        switch error {
        case RepositoryServiceError.empty:
            return Constant.noRepos
        case RepositoryServiceError.invalidStatusCode:
            return Constant.invalidStatusCodeError
        case RepositoryServiceError.failedToDecode:
            return Constant.failedToDecodeError
        case RepositoryServiceError.incorrectUserName:
            return Constant.incorrectUserNameError
        default:
            return Constant.unknownError
        }
    }
}

extension RepositoryListFeature.State.RequestState: Equatable {
    static func == (lhs: RepositoryListFeature.State.RequestState, rhs: RepositoryListFeature.State.RequestState) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading):
            return true
        case (.failed(let lhsMessage) ,.failed(let rhsMessage)):
            return lhsMessage == rhsMessage
        case (.loaded(let lhsRepos), .loaded(let rhsRepos)):
            return lhsRepos.count == rhsRepos.count
        default:
            return false
        }
    }
}

extension RepositoryListFeature.Action: Equatable {
    static func == (lhs: RepositoryListFeature.Action, rhs: RepositoryListFeature.Action) -> Bool {
        switch (lhs, rhs) {
        case (.onAppear, .onAppear):
            return true
        case (.showError, .showError):
            return true
        case (.showRepository(let lhsRepos), .showRepository(let rhsRepos)):
            return lhsRepos.count == rhsRepos.count
        default:
            return false
        }
    }
}
