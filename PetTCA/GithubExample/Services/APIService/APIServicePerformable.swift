//
//  APIServicePerformable.swift
//  SwiftUIGitHubApp
//
//  Created by Viktor Drykin on 25.07.2024.
//

import Foundation

protocol APIServicePerformable {
    func perform<Output: Decodable>(urlRequest: URLRequest) async throws -> Output
}
