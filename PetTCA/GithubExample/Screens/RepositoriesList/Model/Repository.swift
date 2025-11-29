//
//  Repository.swift
//  GithubReposSearcher
//
//  Created by Viktor Drykin on 25.07.2024.
//

import Foundation

struct Repository: Identifiable {
    let id: Int
    let title: String
    let description: String?
    let url: URL?

    init(id: Int, title: String, description: String?, url: URL?) {
        self.id = id
        self.title = title
        self.description = description
        self.url = url
    }
}

extension Repository {
    init(with dto: RepositoryDTO) {
        self.init(id: dto.id, title: dto.name, description: dto.description, url: dto.url)
    }
}


