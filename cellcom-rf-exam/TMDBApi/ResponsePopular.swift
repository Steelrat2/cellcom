//
//  ResponseFavorites.swift
//  cellcom-rf-exam
//
//  Created by Dimitry Antonov on 24/08/2021.
//

import Foundation

struct PopularMoviesResponse: Codable {
    
    let page: Int
    let total_pages: Int
    let total_results: Int
    let results: [Movie]
    
    struct Movie: Codable {
        let adult: Bool
        let backdrop_path: String
        let genre_ids: [Int]
        let id: Int
        let original_language: String
        let original_title: String
        let overview: String
        let popularity: Float
        let poster_path: String
        let release_date: String
        let title: String
        let video: Bool
        let vote_average: Float
        let vote_count: Float
    }
    
    
}

extension PopularMoviesResponse.Movie {
    func with(
        adult: Bool,
        backdropPath: String,
        genreIDS: [Int],
        id: Int,
        originalLanguage: String,
        originalTitle: String,
        overview: String,
        popularity: Float,
        posterPath: String,
        releaseDate: String,
        title: String,
        video: Bool,
        voteAverage: Float,
        voteCount: Float
    ) -> PopularMoviesResponse.Movie {
        return PopularMoviesResponse.Movie(
            adult: adult,
            backdrop_path: backdropPath,
            genre_ids: genreIDS,
            id: id ,
            original_language: originalLanguage,
            original_title: originalTitle,
            overview: overview,
            popularity: popularity,
            poster_path: posterPath,
            release_date: releaseDate,
            title: title,
            video: video,
            vote_average: voteAverage,
            vote_count: voteCount
        )
    }
}
