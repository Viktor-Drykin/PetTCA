//
//  Dependency.swift
//  PetTCA
//
//  Created by Viktor Drykin on 30.11.2025.
//
import ComposableArchitecture

private enum APIClientKey: DependencyKey {
    static let liveValue: APIServicePerformable = APIClient()
}

private enum RepositoryServiceKey: DependencyKey {
    static let liveValue: RepositoriesService = RepositoriesServiceImpl(apiService: APIClient())
}

extension DependencyValues {
    var apiClient: APIServicePerformable {
        get { self[APIClientKey.self] }
        set { self[APIClientKey.self] = newValue }
    }
    
    var repositoryService: RepositoriesService {
        get { self[RepositoryServiceKey.self] }
        set { self[RepositoryServiceKey.self] = newValue }
    }
}
