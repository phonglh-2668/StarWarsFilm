//
//  Error.swift
//  StarWarFilms
//
//  Created by le.hung.phong on 06/02/2024.
//

import Foundation
import Apollo

enum APIError: Error {
    case failed([GraphQLError])
}
