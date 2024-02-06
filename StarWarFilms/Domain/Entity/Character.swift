//
//  Character.swift
//  StarWarFilms
//
//  Created by le.hung.phong on 06/02/2024.
//

import Foundation
import StarWarsAPI

struct Character {
    let name: String
    
    init(data: StarWarFilmsQuery.Data.AllFilms.Film.CharacterConnection.Character) {
        self.name = data.name ?? ""
    }
}
