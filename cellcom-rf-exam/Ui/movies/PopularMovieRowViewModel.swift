//
//  PopularMovieRowViewModel.swift
//  cellcom-rf-exam
//
//  Created by Dimitry Antonov on 24/08/2021.
//
import Foundation
import SwiftUI

struct PopularMovieRowViewModel: Identifiable {
    private let item: PopularMoviesResponse.Movie
    
    var id: Int {
        return item.id
    }
    
    var date: Date {
                
        return tmbdFormatter.date(from: item.release_date) ?? Date.init()
    }
    
    var day: String {
        return item.release_date
    }
    
    var voteAverage: String {
        
        return "\(item.vote_average)"
    }

    var title: String {
   
        return item.title
    }
    
    var fullDescription: String {
        return item.title
    }
    
    var imagePath: String {
        return item.poster_path
    }
    
    var movie: PopularMoviesResponse.Movie {
        return item
    }
    
    init(item: PopularMoviesResponse.Movie) {
        self.item = item
    }
}

// Used to hash on just the day in order to produce a single view model for each
// day when there are multiple items per each day.
extension PopularMovieRowViewModel: Hashable {
    static func == (lhs: PopularMovieRowViewModel, rhs: PopularMovieRowViewModel) -> Bool {
        return lhs.day == rhs.day
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.day)
    }
}
