//
//  PopulaMoviesView.swift
//  cellcom-rf-exam
//
//  Created by Dimitry Antonov on 24/08/2021.
//

import SwiftUI


enum Menu: String, CaseIterable, Identifiable {
    case popular
    case ongoing
    case favorites
    
    var id: String { self.rawValue }
}

struct PopularMoviesView: View {
    
    @ObservedObject var viewModel: PopularMoviesViewModel
    @State private var selectedMenu = Menu.popular.rawValue

    init(viewModel: PopularMoviesViewModel) {
        self.viewModel = viewModel
    }
        
    var body: some View {
        
        NavigationView {
            
            List {
                pickerList
                if viewModel.dataSource.isEmpty {
                    emptySection
                } else {
                    
                    movieSection
                }
            }
            
            .listStyle(GroupedListStyle())
            .navigationBarTitle("\(selectedMenu.capitalized) Movies")
            
        }
    }
}


private extension PopularMoviesView {
    
    
    var pickerList: some View {
                
        Picker( selection: $selectedMenu,label:Text("menuPicker")) {
            ForEach(Menu.allCases) { menu in
                Text(menu.rawValue.capitalized)
            }
        }.pickerStyle(SegmentedPickerStyle())
        .onChange(of: selectedMenu, perform: { value in
            
            NSLog("\(value)")
            switch value {
                case Menu.popular.rawValue:
                    ///TODO: get popular
                    self.viewModel.fetchPopularMovies(reload: true)
                    break
                case Menu.favorites.rawValue:
                    ///TODO: get favorites
                    self.viewModel.fetchPopularMovies(reload: true)
                    break
                case Menu.ongoing.rawValue:
                    ///TODO: get ongoing
                    self.viewModel.fetchOngoingMovies(reload: true)
                    break
                default:
                break
            }
        })
        
    }
    
    
    var movieSection: some View {

        ForEach(viewModel.dataSource) { pmrvm in
            
            NavigationLink(destination: viewModel.currentMovieView(movie: pmrvm.movie)) {  MovieRow.init(viewModel:pmrvm)
            }
            
            .onAppear() {
                if pmrvm == viewModel.dataSource.last {
                    
                    switch selectedMenu {
                        case Menu.popular.rawValue:
                            ///TODO: get popular
                            self.viewModel.fetchPopularMovies()
                            break
                        case Menu.favorites.rawValue:
                            ///TODO: get favorites
                            self.viewModel.fetchPopularMovies()
                            break
                        case Menu.ongoing.rawValue:
                            ///TODO: get ongoing
                            self.viewModel.fetchOngoingMovies()
                            break
                        default:
                            break
                    }
                }
            }
        }
        
    }
    
    
    var emptySection: some View {
        Section {
            Text("No results")
                .foregroundColor(.gray)
        }
    }
}

struct PopularMoviesView_Previews: PreviewProvider {
    static var previews: some View {
        
        let fetcher = MovieFetcher()
        let viewModel = PopularMoviesViewModel(moviesFetcher: fetcher)
        
        PopularMoviesView(viewModel: viewModel)
    }
}

