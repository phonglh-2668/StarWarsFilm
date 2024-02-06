//
//  HomeViewModel.swift
//  StarWarFilms
//
//  Created by le.hung.phong on 06/02/2024.
//

import Foundation
import Combine
import StarWarsAPI
import Resolver

struct HomeViewModel {
    @Injected var starWarsUseCase: StarWarsUseCaseType
}

extension HomeViewModel: ViewModel {
    final class Input: ObservableObject {
        @Published var searchText = ""
        let loadTrigger: Driver<Void>
        
        init(loadTrigger: Driver<Void>) {
            self.loadTrigger = loadTrigger
        }
    }
    
    final class Output: ObservableObject {
        @Published var films = [Film]()
        @Published var isLoading = false
        @Published var alert = AlertMessage()
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let output = Output()
        let errorTracker = ErrorTracker()
        let activityIndicator = ActivityTracker(false)
        
        let loadData = input.loadTrigger
            .flatMap {
                return starWarsUseCase.getAllFilms()
                    .trackError(errorTracker)
                    .trackActivity(activityIndicator)
                    .catch { _ in Empty() }
                    .eraseToAnyPublisher()
            }
            .share()
        
        Publishers
            .CombineLatest(input.$searchText, loadData)
            .map { text, films in
                guard !text.isEmpty else {
                    return films
                }
                return films.filter { $0.title.contains(text) }
            }
            .assign(to: \.films, on: output)
            .store(in: cancelBag)
        
        errorTracker
            .eraseToAnyPublisher()
            .receive(on: RunLoop.main)
            .map { AlertMessage(error: $0) }
            .assign(to: \.alert, on: output)
            .store(in: cancelBag)
        
        activityIndicator
            .eraseToAnyPublisher()
            .assign(to: \.isLoading, on: output)
            .store(in: cancelBag)
        
        return output
    }
}
