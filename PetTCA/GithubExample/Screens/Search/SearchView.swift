//
//  SearchView.swift
//  SwiftUIGitHubApp
//
//  Created by Viktor Drykin on 21.10.2024.
//

import SwiftUI
import ComposableArchitecture

struct SearchView: View {
    
    @Bindable var store: StoreOf<SearchReducer>
    
    var body: some View {
        NavigationStack(
            path: $store.scope(state: \.path, action: \.path)
        ) {
            searchView
        } destination: { store in
            switch store.case {
            case .repositories(let store):
                RepositoryListView(store: store)
            }
        }
    }
    
    var searchView: some View {
        ZStack(alignment: .top) {
            
            LinearGradient(
                colors: [
                    .background1,
                    .background1.opacity(0.6),
                    .background1.opacity(0.2),
                    .background2
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack(alignment: .center, spacing: 40) {
                Text("Search GitHub\nUser's repos")
                    .multilineTextAlignment(.center)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.accentColor)
                TextField("Enter user name", text: $store.userName)
                    .autocorrectionDisabled()
                    .padding()
                    .frame(minHeight: 40)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(.accent, lineWidth: 1)
                    )
                    .padding(16)
                NavigationLink(
                    state: SearchReducer.Destination.State.repositories(RepositoryListFeature.State(userName: store.userName))
                ) {
                    Text("Enter")
                        .font(.title)
                        .fontWeight(.semibold)
                }
            }
        }
    }
}

#Preview {
    SearchView(store: .init(initialState: .init(), reducer: { SearchReducer() } ))
}
