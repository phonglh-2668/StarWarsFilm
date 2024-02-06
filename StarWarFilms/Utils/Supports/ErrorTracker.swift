//
//  ErrorTracker.swift
//  StarWarFilms
//
//  Created by le.hung.phong on 06/02/2024.
//

import Foundation
import Combine

public typealias ErrorTracker = PassthroughSubject<Error, Never>

extension Publisher {
    public func trackError(_ errorTracker: ErrorTracker) -> AnyPublisher<Output, Failure> {
        return handleEvents(receiveCompletion: { completion in
            if case let .failure(error) = completion {
                errorTracker.send(error)
            }
        })
        .eraseToAnyPublisher()
    }
}
