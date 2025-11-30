//
//  PullRequestListView.swift
//  SwiftUIGitHubApp
//
//  Created by Viktor Drykin on 06.11.2024.
//

import SwiftUI

struct PullRequestListView: View {

    @ObservedObject var viewModel: PullRequestListViewModel

    init(viewModel: PullRequestListViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        return ScrollView {
            if let error = viewModel.error {
                Text(error)
            } else {
                ForEach(viewModel.pullRequests) { pullRequest in
                    PullRequestItemView(pullRequestItem: pullRequest)
                }
            }
        }
//        .onAppear {
//            viewModel.fetchPullRequests()
//        }
    }
}

//#Preview {
//    PullRequestListView(viewModel: PullRequestListViewModel(apiService: PullRequestServiceImpl(apiService: CombineAPIClient()), repoName: "SwiftUIGithubApp", userName: "Viktor-Drykin"))
//}
