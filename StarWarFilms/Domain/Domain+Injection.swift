//
//  Domain+Injection.swift
//  StarWarFilms
//
//  Created by le.hung.phong on 06/02/2024.
//

import Foundation
import Resolver

extension Resolver {
    static func registerDomain() {
        register { StarWarsUseCase() as StarWarsUseCaseType }
    }
}
