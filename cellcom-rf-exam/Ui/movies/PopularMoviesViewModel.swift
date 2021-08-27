//
//  PopularMoviesViewModel.swift
//  cellcom-rf-exam
//
//  Created by Dimitry Antonov on 24/08/2021.
//

import SwiftUI
import Combine

class PopularMoviesViewModel: ObservableObject {
    
    @Published var dataSource: [PopularMovieRowViewModel] = []
    
    private let moviesFetcher: MovieFetchable
    private var disposables = Set<AnyCancellable>()
    private var currentPageOngoing = 0
    private var currentPagePopular = 0

    init(
        moviesFetcher: MovieFetchable,
        scheduler: DispatchQueue = DispatchQueue(label: "MovieViewModel")
    ) {
        self.moviesFetcher = moviesFetcher
        self.fetchPopularMovies()
    }
    
    
    func fetchOngoingMovies(reload: Bool = false) {
        
        self.currentPageOngoing += 1
        if(reload) {
            self.dataSource.removeAll()
            self.currentPagePopular = 0
            self.currentPageOngoing = 0
        }
        
    
        moviesFetcher.ongoingMovies(page: currentPageOngoing)
            .map { response in
                response.results.map(PopularMovieRowViewModel.init)
            }
            .map(Array.removeDuplicates)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] value in
                    guard let self = self else { return }
                    switch value {
                        case .failure:
                            self.dataSource = []
                        case .finished:
                            break
                    }
                },
                receiveValue: { [weak self] movies in
                    guard let self = self else { return }
                    self.dataSource += movies.sorted(by: { $0.date > $1.date })
                })
            .store(in: &disposables)
        
    }
    
    func fetchPopularMovies(reload: Bool = false) {
        self.currentPagePopular += 1
        if(reload) {
            self.dataSource.removeAll()
            self.currentPagePopular = 0
            self.currentPageOngoing = 0
        }
        
        moviesFetcher.popularMovies(page: currentPagePopular)
            .map { response in
                response.results.map(PopularMovieRowViewModel.init)
            }
            .map(Array.removeDuplicates)            
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] value in
                    guard let self = self else { return }
                    switch value {
                        case .failure:
                            self.dataSource = []
                        case .finished:
                            break
                    }
                },
                receiveValue: { [weak self] movies in
                    guard let self = self else { return }                    
                    self.dataSource += movies.sorted(by: { $0.date > $1.date })
                })
            .store(in: &disposables)
    }
}

extension PopularMoviesViewModel {
    var popularMoviesView: some View {
        
        return PopularMoviesBuilder.makePopularMoviesView(
            moviesFetcher: moviesFetcher
        )
        
    }
    
    func currentMovieView(movie:PopularMoviesResponse.Movie) ->  some View {
        
        return PopularMoviesBuilder.makeMovieDetailsView(movie: movie)
        
    }
    
    
}
