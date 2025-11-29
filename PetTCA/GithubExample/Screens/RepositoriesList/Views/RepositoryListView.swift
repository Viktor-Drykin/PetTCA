//
//  RepositoryListView.swift
//  SwiftUIGitHubApp
//
//  Created by Viktor Drykin on 20.10.2024.
//

import SwiftUI
import ComposableArchitecture

struct RepositoryListView: View {

    var store: StoreOf<RepositoryListFeature>
    //@ObservedObject var viewModel: RepositoryListViewModel
    var userName: String = "Set username"

    var body: some View {
        ScrollView {
//            switch store.state {
//            case .loading:
//                ProgressView()
//            case .loaded(let repoList):
//                contentView(with: repoList)
//            case .failed(let message):
//                errorView(with: message)
//            }
        }
        .scrollIndicators(.hidden)
        .padding()
        .onAppear {
            store.send(.requestRepositoryList)
            //viewModel.searchRepositories(for: userName)
        }
        .navigationTitle(userName)
    }

    private func contentView(with repoList: [Repository]) -> some View {
        LazyVStack(
            alignment: .leading,
            spacing: 20,
            pinnedViews: [.sectionHeaders]) {
                Section {
                    ForEach(repoList) { repository in
//                        NavigationLink(value: NavigationDestinations.pullRequests(userName: userName, repoName: repository.title)) {
//                            RepositoryItemView(repoName: repository.title, repoDescription: repository.description)
//                        }
                    }
                } header: {
                    Text("Repositories")
                        .font(.title)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(8)
                        .background(
                            Color.white.opacity(0.9)
                        )
                }

            }
    }

    private func errorView(with errorText: String) -> some View {
        Text(errorText)
            .font(.title)
            .fontWeight(.medium)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .transition(.move(edge: .top))
            //.animation(.bouncy, value: store.state)
    }
}

//#Preview {
//    let apiService = APIClient()
//    let repositoriesService = RepositoriesServiceImpl(apiService: apiService)
//    let viewModel = RepositoryListViewModel(repositoriesService: repositoriesService)
//    return RepositoryListView(viewModel: viewModel, userName: "John Doe")
//}
