//
//  Publisher+.swift
//  StarWarFilms
//
//  Created by le.hung.phong on 06/02/2024.
//

import Foundation
import Combine

extension Publisher {
    public func withUnretained<Root: AnyObject>(_ object: Root) -> AnyPublisher<(object: Root, value: Self.Output), Self.Failure> {
        let mapped = compactMap { [weak object] value -> (object: Root, value: Self.Output)? in
            guard let object = object else { return nil }
            return (object: object, value: value)
        }
        return mapped.eraseToAnyPublisher()
    }
}
