//
//  RepositoryListViewModel.swift
//  GithubReposSearcher
//
//  Created by Viktor Drykin on 25.07.2024.
//

import Foundation
import Combine

final class RepositoryListViewModel: ObservableObject {

    enum State {
        case loading
        case loaded([Repository])
        case failed(message: String)
    }
    
    enum Constant {
        static let noRepos = "There are no repositories"
        static let invalidStatusCodeError = "Error: invalidStatusCode"
        static let failedToDecodeError = "Error: failedToDecode"
        static let incorrectUserNameError = "Error: incorrectUserName"
        static let unknownError = "Error: something went wrong"
    }
    
    @Published var state: State = .loading
    
    private let repositoriesService: RepositoriesService
    
    init(repositoriesService: RepositoriesService) {
        self.repositoriesService = repositoriesService
    }

    func searchRepositories(for user: String) {
        state = .loading
        Task {
            do {
                let repos = try await repositoriesService.fetchRepos(with: user)
                await MainActor.run {
                    state = .loaded(repos.map(Repository.init))
                }
            } catch {
                await MainActor.run {
                    state = state(for: error)
                }
            }
        }
    }
    
    private func state(for error: Error) -> State {
        let errorMessage: String = {
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
        }()
        return .failed(message: errorMessage)
    }
}

extension RepositoryListViewModel.State: Equatable {
    static func == (lhs: RepositoryListViewModel.State, rhs: RepositoryListViewModel.State) -> Bool {
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
