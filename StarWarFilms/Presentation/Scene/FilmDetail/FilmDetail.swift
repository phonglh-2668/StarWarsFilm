//
//  FilmDetail.swift
//  StarWarFilms
//
//  Created by le.hung.phong on 06/02/2024.
//

import SwiftUI

struct FilmDetail: View {
    let film: Film
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text(film.title)
                    .font(.title2)
                    .bold()
                    .padding(.bottom, 4)
                if let episodeID = film.episodeID {
                    showItem(title: "Episode ID", content: "\(episodeID)")
                }
                showItem(title: "Release date", content: film.releaseDate)
                showItem(title: "Opening crawl", content: film.openingCrawl)
                showItem(title: "Characters", content: film.characters)
                Spacer()
            }
            .padding(.horizontal, 8)
        }
    }
    
    @ViewBuilder
    private func showItem(title: String, content: String) -> some View {
        VStack(alignment: .leading) {
            Text("\(title): ").bold() + Text(content)
            Spacer()
        }
    }
}
