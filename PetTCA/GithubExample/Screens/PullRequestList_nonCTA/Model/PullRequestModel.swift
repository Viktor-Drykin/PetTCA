//
//  PullRequestModel.swift
//  SwiftUIGitHubApp
//
//  Created by Viktor Drykin on 06.11.2024.
//

import Foundation

struct PullRequestModel {
    let id: String = UUID().uuidString
    let title: String
    let name: String
    let createdAt: String
    let closedAt: String
    let labels: [Label]
    let state: String?

    struct Label {
        let name: String
        let color: UInt
    }
}

extension PullRequestModel: Identifiable {}

extension PullRequestModel {
    init(with prDTO: PullRequestDTO) {
        let title = [
            prDTO.base?.repo?.fullName,
            prDTO.number.flatMap { "#\($0)" },
            ]
            .compactMap { $0 }
            .joined(separator: " ")

        self.init(
            title: title,
            name: prDTO.title ?? "",
            createdAt: prDTO.createdAt?.description ?? "",
            closedAt: prDTO.closedAt?.description ?? "",
            labels: prDTO.labels?.compactMap { label in
                if let name = label.name {
                    return .init(name: name, color: UInt(label.color ?? "", radix: 16) ?? 0)
                } else {
                    return nil
                }
            } ?? [],
            state: nil
        )
    }
}
