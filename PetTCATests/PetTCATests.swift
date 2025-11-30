//
//  PetTCATests.swift
//  PetTCATests
//
//  Created by Viktor Drykin on 23.11.2025.
//

import Testing
import ComposableArchitecture
@testable import PetTCA
import Foundation

struct RepositoryListFeatureTest {
    
    @Test
    func test_onAppear_success() async throws {
        // Arrange
        let dto = RepositoryDTO(id: 1, name: "RepoA", description: "A repo", url: nil)
        let service = RepositoryServiceMock()
        service.result = .success([dto])
        
        let store = TestStore(
            initialState: .init(userName: "Apple")
        ) {
            RepositoryListFeature()
        } withDependencies: {
            $0.repositoryService = service
        }
        
        // Act & Assert
        await store.send(.onAppear) {
            $0.requestState = .loading
        }
        
        await store.receive(.showRepository(list: [Repository(dto: dto)])) {
            $0.requestState = .loaded([Repository(dto: dto)])
        }
    }
    
    @Test
    func test_onAppear_error_empty() async throws {
        
        let service = RepositoryServiceMock()
        service.result = .failure(RepositoryServiceError.empty)
        
        let store = TestStore(
            initialState: .init(userName: "Apple")
        ) {
            RepositoryListFeature()
        } withDependencies: {
            $0.repositoryService = service
        }
        
        await store.send(.onAppear) {
            $0.requestState = .loading
        }
        
        await store.receive(.showError(message: RepositoryListFeature.Constant.noRepos)) {
            $0.requestState = .failed(message: RepositoryListFeature.Constant.noRepos)
        }
    }
    
    @Test
    func test_onAppear_error_invalidStatusCode() async throws {
        let service = RepositoryServiceMock()
        service.result = .failure(RepositoryServiceError.invalidStatusCode)
        
        let store = TestStore(
            initialState: .init(userName: "Apple")
        ) {
            RepositoryListFeature()
        } withDependencies: {
            $0.repositoryService = service
        }
        
        await store.send(.onAppear) {
            $0.requestState = .loading
        }
        
        await store.receive(.showError(message: RepositoryListFeature.Constant.invalidStatusCodeError)) {
            $0.requestState = .failed(message: RepositoryListFeature.Constant.invalidStatusCodeError)
        }
    }
    
    @Test
    func test_onAppear_error_failedToDecode() async throws {
        let service = RepositoryServiceMock()
        service.result = .failure(RepositoryServiceError.failedToDecode)
        
        let store = TestStore(
            initialState: .init(userName: "Apple")
        ) {
            RepositoryListFeature()
        } withDependencies: {
            $0.repositoryService = service
        }
        
        await store.send(.onAppear) {
            $0.requestState = .loading
        }
        
        await store.receive(.showError(message: RepositoryListFeature.Constant.failedToDecodeError)) {
            $0.requestState = .failed(message: RepositoryListFeature.Constant.failedToDecodeError)
        }
    }
    
    @Test
    func test_onAppear_error_incorrectUserName() async throws {
        let service = RepositoryServiceMock()
        service.result = .failure(RepositoryServiceError.incorrectUserName)
        
        let store = TestStore(
            initialState: .init(userName: "Apple")
        ) {
            RepositoryListFeature()
        } withDependencies: {
            $0.repositoryService = service
        }
        
        await store.send(.onAppear) {
            $0.requestState = .loading
        }
        
        await store.receive(.showError(message: RepositoryListFeature.Constant.incorrectUserNameError)) {
            $0.requestState = .failed(message: RepositoryListFeature.Constant.incorrectUserNameError)
        }
    }
    
    @Test
    func test_onAppear_error_unknown() async throws {
        let service = RepositoryServiceMock()
        service.result = .failure(NSError(domain: "Test", code: -1))
        
        let store = TestStore(
            initialState: .init(userName: "Apple")
        ) {
            RepositoryListFeature()
        } withDependencies: {
            $0.repositoryService = service
        }
        
        await store.send(.onAppear) {
            $0.requestState = .loading
        }
        
        await store.receive(.showError(message: RepositoryListFeature.Constant.unknownError)) {
            $0.requestState = .failed(message: RepositoryListFeature.Constant.unknownError)
        }
    }
}

class RepositoryServiceMock: RepositoriesService {
    
    var result: Result<[RepositoryDTO], Error> = .success([])
    
    func fetchRepos(with user: String) async throws -> [RepositoryDTO] {
        switch result {
        case .success(let repos):
            return repos
        case .failure(let error):
            throw error
        }
    }
}
