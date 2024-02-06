//
//  ViewModel.swift
//  StarWarFilms
//
//  Created by le.hung.phong on 06/02/2024.
//

import Combine

public protocol ViewModel {
    associatedtype Input
    associatedtype Output
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output
}
