//
//  MovieFetcher.swift
//  cellcom-rf-exam
//
//  Created by Dimitry Antonov on 24/08/2021.
//

import Foundation
import Combine

protocol MovieFetchable {
    
    func popularMovies(page: Int) -> AnyPublisher<PopularMoviesResponse,MovieError>
    func ongoingMovies(page: Int) -> AnyPublisher<PopularMoviesResponse,MovieError>
}

class MovieFetcher {
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session;
        
    }
}

extension MovieFetcher: MovieFetchable {
   
    func popularMovies(page: Int) -> AnyPublisher<PopularMoviesResponse, MovieError> {
        
        return popular(with: makePopularMoviesComponents(page:page))
    }
    
    func ongoingMovies(page: Int) -> AnyPublisher<PopularMoviesResponse, MovieError> {
        
        return popular(with: makeOngoingMoviesComponents(page: page))
    }
    
    
    private func popular<T>(
        with components: URLComponents
    ) -> AnyPublisher<T, MovieError> where T: Decodable {
        guard let url = components.url else {
            let error = MovieError.network(description: "Couldn't create URL")
            return Fail(error: error).eraseToAnyPublisher()
        }
        return session.dataTaskPublisher(for: URLRequest(url: url))
            .mapError { error in
                .network(description: error.localizedDescription)
            }
            .flatMap(maxPublishers: .max(1)) { pair in
                
                decode(pair.data)
            }
            .eraseToAnyPublisher()
    }
    
}


private extension MovieFetcher {
    
    
    
    struct TMBDAPI {
        static let scheme = "https"
        static let host = "api.themoviedb.org"
        static let path = "/3/movie"
        static let key = "2c46288716a18fb7aadcc2a801f3fc6b"
    }
    
    func makePopularMoviesComponents(page:Int
    ) -> URLComponents {
        var components = URLComponents()
        components.scheme = TMBDAPI.scheme
        components.host = TMBDAPI.host
        components.path = TMBDAPI.path + "/popular"
        
        
        components.queryItems = [
            URLQueryItem(name: "api_key", value: TMBDAPI.key),
            URLQueryItem(name: "page", value: "\(page)")
        ]
        
        return components
    }

    
    func makeOngoingMoviesComponents(page:Int
    ) -> URLComponents {
        var components = URLComponents()
        components.scheme = TMBDAPI.scheme
        components.host = TMBDAPI.host
        components.path = TMBDAPI.path + "/now_playing"
        
        
        components.queryItems = [
            URLQueryItem(name: "api_key", value: TMBDAPI.key),
            URLQueryItem(name: "page", value: "\(page)")
        ]
        
        return components
    }

    
}
