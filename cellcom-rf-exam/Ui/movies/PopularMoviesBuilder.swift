//
//  PopularMoviesBuilder.swift
//  cellcom-rf-exam
//
//  Created by Dimitry Antonov on 24/08/2021.
//

import SwiftUI

enum PopularMoviesBuilder {
    static func makePopularMoviesView(
        moviesFetcher: MovieFetchable
    ) -> some View {
        let viewModel = PopularMoviesViewModel(
            moviesFetcher: moviesFetcher)
        return PopularMoviesView(viewModel: viewModel)
    }
    
    
    static func makeMovieDetailsView(
        movie: PopularMoviesResponse.Movie
    ) -> some View {
        let viewModel = MovieDetailsViewModel(movie: movie)
        return MovieDetailsView(viewModel: viewModel)
    }
}
