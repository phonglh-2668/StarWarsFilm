//
//  Film.swift
//  StarWarFilms
//
//  Created by le.hung.phong on 06/02/2024.
//

import Foundation
import StarWarsAPI

struct Film {
    let title: String
    let releaseDate: String
    let openingCrawl: String
    let episodeID: Int?
    let characters: String
    
    init(data: StarWarFilmsQuery.Data.AllFilms.Film) {
        self.title = data.title ?? ""
        self.releaseDate = data.releaseDate ?? ""
        self.openingCrawl = data.openingCrawl ?? ""
        self.episodeID = data.episodeID ?? 0
        self.characters = data.characterConnection?
            .characters?
            .compactMap { $0 }
            .map { Character(data: $0).name }
            .joined(separator: ", ") ?? ""
    }
}
