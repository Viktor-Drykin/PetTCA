//
//  RepositoriesServiceImpl.swift
//  SwiftUIGitHubApp
//
//  Created by Viktor Drykin on 25.07.2024.
//

import Foundation

enum RepositoryServiceError: Error, Comparable {
    case incorrectUserName
    case incorrectURL
    case invalidStatusCode
    case failedToDecode
    case empty
}

class RepositoriesServiceImpl {

    private let userNamePlaceholder = "#USER_NAME#"
    private let urlPath = "https://api.github.com/users/#USER_NAME#/repos"
    private let apiService: APIServicePerformable

    init(apiService: APIServicePerformable) {
        self.apiService = apiService
    }
}

extension RepositoriesServiceImpl: RepositoriesService {

    func fetchRepos(with user: String) async throws -> [RepositoryDTO] {

        let urlRequest = URLRequest(userName: user, urlPath: urlPath, replacedPattern: userNamePlaceholder)

        guard let request = urlRequest else {
            throw RepositoryServiceError.incorrectURL
        }

        do {
            let repositories: [RepositoryDTO] = try await apiService.perform(urlRequest: request)
            guard !repositories.isEmpty else {
                throw RepositoryServiceError.empty
            }
            return repositories
        } catch NetworkError.failedToDecode {
            throw RepositoryServiceError.failedToDecode
        } catch NetworkError.invalidStatusCode {
            throw RepositoryServiceError.invalidStatusCode
        }
    }
}

fileprivate extension URLRequest {
    init?(userName: String, urlPath: String, replacedPattern: String) {
        guard let encodedUser = userName.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed), !encodedUser.isEmpty else {
            return nil
        }

        let replacedURLPath = urlPath.replacing(replacedPattern, with: encodedUser, maxReplacements: 1)

        guard let url = URL(string: replacedURLPath) else {
            return nil
        }

        self.init(url: url)
    }
}
