//
//  PullRequestItemView.swift
//  SwiftUIGitHubApp
//
//  Created by Viktor Drykin on 08.11.2024.
//

import SwiftUI

struct PullRequestItemView: View {

    let pullRequestItem: PullRequestModel

    init(pullRequestItem: PullRequestModel) {
        self.pullRequestItem = pullRequestItem
    }

    var body: some View {
        HStack(alignment: .top) {
            Image(systemName: "star.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 30, alignment: .topLeading)
                .padding(.horizontal)

            VStack(alignment: .leading) {
                HStack(alignment: .firstTextBaseline, spacing: 4) {
                    Text(pullRequestItem.title)
                        .foregroundStyle(Color.secondary)
                }
                Text(pullRequestItem.name)
                    .bold()
                Grid(alignment: .leading, horizontalSpacing: 12, verticalSpacing: 12) {
                    ForEach(pullRequestItem.labels, id: \.name) { item in
                        Text(item.name)
                            .foregroundStyle(Color.white)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 4)
                            .background(
                                Capsule()
                                    .fill(Color(hex: item.color))
                            )
                    }
                }
                HStack {
                    HStack() {
                        Image(systemName: "xmark")
                            .foregroundStyle(Color.red)
                            .font(.caption2)
                        Text("Checks")

                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(
                        Capsule()
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    HStack(spacing: 2) {
                        Image(systemName: "checkmark")
                            .font(.caption2)
                            .foregroundStyle(Color.green)
                        Text("Reviews")
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(
                        Capsule()
                            .stroke(Color.gray, lineWidth: 1)
                    )
                }
            }
            Text("2d")
                .font(.title3)
                .multilineTextAlignment(.leading)
                .padding(.horizontal)
        }
    }
}

#Preview {
    PullRequestItemView(
        pullRequestItem: .init(
            title: "Viktor-Drykin/SwiftUIGithubApp #1",
            name: "Add view model to a pull request screen",
            createdAt: "2024-11-06T15:46:16Z",
            closedAt: "2024-11-06T15:46:16Z",
            labels: [
                .init(
                    name: "help wanted",
                    color: UInt("000000", radix: 16) ?? 0
                )
            ],
            state: nil
        )
    )
}
