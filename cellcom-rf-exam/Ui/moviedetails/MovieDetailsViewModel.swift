//
//  MovieDetailsViewModel.swift
//  cellcom-rf-exam
//
//  Created by Dimitry Antonov on 25/08/2021.
//

import Foundation

class MovieDetailsViewModel: ObservableObject {
    
    @Published var movie: PopularMoviesResponse.Movie

    
    init(movie: PopularMoviesResponse.Movie) {
        
        self.movie = movie
    }
}
