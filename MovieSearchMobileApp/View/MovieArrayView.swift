//
//  ContentView.swift
//  MovieSearchMobileApp
//
//  Created by Berkan Gezgin on 22.01.2022.
//

import SwiftUI

struct MovieArrayView: View {
    // ------ Gözlemlenen obje ------
    @ObservedObject var movieArrayViewModel : MovieArrayViewModel
    // Gözlemlenenen olması için @ObservedObject property olarak ekledik.
    
    @State var searchMovie = ""
    
    init() {
        self.movieArrayViewModel = MovieArrayViewModel()
        self.movieArrayViewModel.doMovieSearch(movieName: "fast")
    }
    
    var body: some View {
        NavigationView{
            
            VStack {
                TextField("Aranacak Film", text: $searchMovie, onEditingChanged: { _ in }, onCommit: {
                self.movieArrayViewModel.doMovieSearch(movieName: searchMovie.trimmingCharacters(in: .whitespacesAndNewlines).addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? searchMovie)
                }).padding().textFieldStyle(RoundedBorderTextFieldStyle())
                    
                List(movieArrayViewModel.movies, id: \.imdbID) { movie in
                NavigationLink(
                    destination: DetailView(imdbID: movie.imdbID),
                    label: {
                        HStack() {
                            
                            PrivateImage(url: movie.poster)
                                .frame(width: 90, height:130)
                            
                            VStack(alignment: .leading) {
                                Text(movie.title)
                                    .font(.title3)
                                    .foregroundColor(.blue)
                                
                                Text(movie.year)
                                    .foregroundColor(.orange)
                            }
                        }
                    })
                }.navigationTitle(Text("Movie Searcher"))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MovieArrayView()
    }
}
