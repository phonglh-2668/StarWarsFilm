//
//  StarWarsRepositoryImpl.swift
//  StarWarsFilms
//
//  Created by le.hung.phong on 06/02/2024.
//

import Foundation
import Combine
import Apollo
import StarWarsAPI

struct StarWarsRepositoryImpl: StarWarsRepository {
    func getAllFilms() -> AnyPublisher<[Film], Error> {
        APIService.shared.fetch(query: StarWarFilmsQuery())
            .map { data in
                guard let films = data.allFilms?.films else {
                    return []
                }
                
                return films
                    .compactMap { $0 }
                    .map { Film(data: $0) }
            }
            .eraseToAnyPublisher()
    }
}
