//
//  RepositoriesDTO.swift
//  SwiftUIGitHubApp
//
//  Created by Viktor Drykin on 25.07.2024.
//

import Foundation

// MARK: - RepositoryListDTO
struct RepositoryListDTO: Decodable {
    let repositories: [RepositoryDTO]
}


// MARK: - RepositoryDTO
struct RepositoryDTO: Decodable {
    let id: Int
    let name: String
    let description: String?
    let url: URL?
}
