//
//  AlertMessage.swift
//  StarWarFilms
//
//  Created by le.hung.phong on 06/02/2024.
//

import Combine

public struct AlertMessage {
    public var title = ""
    public var message = ""
    public var isShowing = false
    
    public init(title: String, message: String, isShowing: Bool) {
        self.title = title
        self.message = message
        self.isShowing = isShowing
    }
    
    public init() {
        
    }
}

public extension AlertMessage {
    init(error: Error) {
        self.title = "Error"
        let message = error.localizedDescription
        self.message = message
        self.isShowing = !message.isEmpty
    }
}
