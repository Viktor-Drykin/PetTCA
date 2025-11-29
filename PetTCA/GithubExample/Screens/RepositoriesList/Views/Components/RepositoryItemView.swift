//
//  RepositoryItemView.swift
//  SwiftUIGitHubApp
//
//  Created by Viktor Drykin on 20.10.2024.
//

import SwiftUI

struct RepositoryItemView: View {

    let repoName: String
    let repoDescription: String?

    var body: some View {
        ZStack {

            LinearGradient(
                colors: [.background1, .background2],
                startPoint: .top,
                endPoint: .bottom
            )
            .clipShape(RoundedRectangle(cornerRadius: 10))

            VStack(alignment: .leading,
                   spacing: 8) {
                Text(repoName)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.accentColor)
                if let repoDescription {
                    Text(repoDescription)
                        .foregroundStyle(Color.secondaryText)
                }
            }
                   .padding(16)
                   .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

#Preview {
    VStack(spacing: 10) {
        RepositoryItemView(repoName: "first-pr", repoDescription: "What was the first pull request you sent on GitHub")
        RepositoryItemView(repoName: "first-pr", repoDescription: "What was")
        RepositoryItemView(repoName: "first-pr", repoDescription: nil)
    }
    .padding(36)
}
