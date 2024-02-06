//
//  APIService.swift
//  StarWarFilms
//
//  Created by le.hung.phong on 06/02/2024.
//

import Apollo
import Foundation
import StarWarsAPI
import Combine

final class APIService {
    static let shared = APIService()
    private var apolloClient: ApolloClient
    
    private init() {
        apolloClient = ApolloClient(url: URL(string: "https://swapi-graphql.netlify.app/.netlify/functions/index")!)
    }
    
    func fetch<Query: GraphQLQuery>(query: Query) -> AnyPublisher<Query.Data, Error> {
        return Future { emitter in
            self.apolloClient.fetch(query: query) { result in
                switch result {
                case let .success(graphResult):
                    if let errors = graphResult.errors {
                        emitter(.failure(APIError.failed(errors)))
                        return
                    }
                    
                    if let data = graphResult.data {
                        emitter(.success(data))
                    }
                case let .failure(error):
                    emitter(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
