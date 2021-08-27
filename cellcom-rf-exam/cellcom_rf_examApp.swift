//
//  cellcom_rf_examApp.swift
//  cellcom-rf-exam
//
//  Created by Dimitry Antonov on 22/08/2021.
//

import SwiftUI

@main
struct cellcom_rf_examApp: App {
    
    var body: some Scene {
        
        let fetcher = MovieFetcher()
        let viewModel = PopularMoviesViewModel(moviesFetcher: fetcher)
        
        WindowGroup {
                    
           PopularMoviesView(viewModel: viewModel)

        }
    }
}
