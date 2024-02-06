//
//  StarWarsUseCase.swift
//  StarWarFilms
//
//  Created by le.hung.phong on 06/02/2024.
//

import Foundation
import Combine
import Resolver

protocol StarWarsUseCaseType {
    func getAllFilms() -> AnyPublisher<[Film], Error>
}

struct StarWarsUseCase: StarWarsUseCaseType {
    @Injected var repository: StarWarsRepository
    
    func getAllFilms() -> AnyPublisher<[Film], Error> {
        repository.getAllFilms()
    }
}
