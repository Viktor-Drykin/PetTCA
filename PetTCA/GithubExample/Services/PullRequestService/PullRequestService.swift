//
//  PullRequestService.swift
//  SwiftUIGitHubApp
//
//  Created by Viktor Drykin on 06.11.2024.
//

import Foundation
import Combine

protocol PullRequestService: AnyObject {    
    func fetchPullRequests(with user: String, repo: String) async throws -> [PullRequestDTO]
}
