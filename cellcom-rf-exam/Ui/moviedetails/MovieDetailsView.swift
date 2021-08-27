//
//  MovieDetails.swift
//  cellcom-rf-exam
//
//  Created by Dimitry Antonov on 25/08/2021.
//

import Foundation
import SwiftUI

struct MovieDetailsView: View {
    
    @ObservedObject var viewModel: MovieDetailsViewModel

    
    init(viewModel: MovieDetailsViewModel) {
        
        self.viewModel = viewModel
        
    }
    
    var body: some View {
        
        NavigationView {
            
            Text(self.viewModel.movie.overview)
                .navigationBarTitle(self.viewModel.movie.title)
        }
    }
}


struct MovieDetailsView_Previews: PreviewProvider {
        
    static var previews: some View {
        
        

        
        let movie = PopularMoviesResponse.Movie(adult:true,backdrop_path: "", genre_ids: [0,1,2], id:1, original_language: "", original_title: "", overview: "Action movie",popularity: 1.0, poster_path: "",release_date: "",title: "Terminator",video: true,vote_average: 1.0, vote_count: 1.0 )
        
        
        
        let viewModel = MovieDetailsViewModel(movie:movie)
        MovieDetailsView(viewModel: viewModel)
    }
    
}
