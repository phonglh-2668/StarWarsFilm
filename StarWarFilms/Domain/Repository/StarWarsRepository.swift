//
//  StarWarsRepository.swift
//  StarWarFilms
//
//  Created by le.hung.phong on 06/02/2024.
//

import Foundation
import Combine

protocol StarWarsRepository {
    func getAllFilms() -> AnyPublisher<[Film], Error>
}
