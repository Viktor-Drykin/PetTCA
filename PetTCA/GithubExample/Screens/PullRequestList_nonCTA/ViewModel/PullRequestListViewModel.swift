//
//  PullRequestListViewModel.swift
//  SwiftUIGitHubApp
//
//  Created by Viktor Drykin on 06.11.2024.
//

import Foundation
import Combine

class PullRequestListViewModel: ObservableObject {
    
    @Published var pullRequests: [PullRequestModel] = []
    @Published var error: String? = nil

    private let apiService: PullRequestService
    private let repoName: String
    private let userName: String
    private var cancellables = Set<AnyCancellable>()

    init(apiService: PullRequestService, repoName: String, userName: String) {
        self.apiService = apiService
        self.repoName = repoName
        self.userName = userName
    }

//    func fetchPullRequests() {
//        apiService.fetchPullRequests(with: userName, repo: repoName)
//            .tryMap { returnedRepos in
//                returnedRepos.map { PullRequestModel(with: $0) }
//            }
//            .receive(on: DispatchQueue.main)
//            .sink { [weak self] completion in
//                switch completion {
//                case .finished:
//                    break
//                case .failure(let error):
//                    self?.error = error.localizedDescription
//                    break
//                }
//            } receiveValue: { [weak self] repos in
//                self?.pullRequests = repos
//            }
//            .store(in: &cancellables)
//    }
}
