//
//  RepositoriesService.swift
//  SwiftUIGitHubApp
//
//  Created by Viktor Drykin on 25.07.2024.
//

import Foundation

protocol RepositoriesService: AnyObject {
    func fetchRepos(with user: String) async throws -> [RepositoryDTO]
}
