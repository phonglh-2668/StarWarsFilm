//
//  HomeView.swift
//  StarWarFilms
//
//  Created by le.hung.phong on 05/02/2024.
//

import SwiftUI
import Combine


struct HomeView: View {
    @ObservedObject var input: HomeViewModel.Input
    @ObservedObject var output: HomeViewModel.Output
    
    private let cancelBag = CancelBag()
    private let loadTrigger = PassthroughSubject<Void, Never>()
    
    init(viewModel: HomeViewModel) {
        let input = HomeViewModel.Input(loadTrigger: loadTrigger.eraseToAnyPublisher())
        self.output = viewModel.transform(input, cancelBag: cancelBag)
        self.input = input
        self.loadTrigger.send(())
    }
    
    var body: some View {
        return LoadingView(isShowing: $output.isLoading, text: .constant("Loading...")) {
            NavigationView {
                VStack {
                    List(output.films, id: \.title) { film in
                        NavigationLink(destination: FilmDetail(film: film)) {
                            VStack(alignment: .leading) {
                                Text(film.title).bold()
                                Text(film.releaseDate)
                            }
                        }
                    }
                }
                .navigationTitle("Star Wars")
                .searchable(text: $input.searchText)
            }
        }
        .alert(isPresented: $output.alert.isShowing) {
            Alert(title: Text(output.alert.title),
                  message: Text(output.alert.message),
                  dismissButton: .default(Text("Retry"), action: {
                loadTrigger.send(())
            }))
        }
    }
}

#Preview {
    HomeView(viewModel: .init())
}
