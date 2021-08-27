//
//  PopularMovieRow.swift
//  cellcom-rf-exam
//
//  Created by Dimitry Antonov on 24/08/2021.
//

import SwiftUI

struct MovieRow: View {
    private let viewModel: PopularMovieRowViewModel
    
    init(viewModel: PopularMovieRowViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack {
            NetworkImage(url: URL(string: "https://www.themoviedb.org/t/p/w150_and_h150_face/\(viewModel.imagePath)"))
                .frame( minWidth: 150, maxWidth:150, minHeight: 150, maxHeight: 150)
                .padding()
            
            VStack(alignment: .leading) {
                Text("\(viewModel.title)")
                    .font(.headline)
                Text("Vote:\(viewModel.voteAverage)")
                    .font(.body)
                Text("\(viewModel.day)")
                    .font(.body)
            }
            .frame(minHeight: 150)
            
            
        }
    }
}
