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
    @State private var showCancelButton: Bool = false
    
    init() {
        self.movieArrayViewModel = MovieArrayViewModel()
        self.movieArrayViewModel.doMovieSearch(movieName: "fast")
    }
    
    var body: some View {
        NavigationView{
            VStack {
                HStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                        
                        TextField("Search Movie", text: $searchMovie, onEditingChanged: { isEditing in
                            self.showCancelButton = true
                        } , onCommit: {
                            
                            // trimmingCharacters : ile arama yaparken boşluk karakterlerini yok ettik. Böylece URL üzerinde arama yaparken sorun çıkmasını engelledik
                            // .addingPercentEncoding : ile boşluk yerine URL formatindeki gibi %20 ekledik
                        
                            self.movieArrayViewModel.doMovieSearch(movieName: searchMovie.trimmingCharacters(in: .whitespacesAndNewlines).addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? searchMovie)
                        }).padding(.leading)
                            
                        Button(action: {
                            self.searchMovie = ""
                        }) { Image(systemName: "xmark.circle.fill").opacity(searchMovie == "" ? 0 : 1) }
                    }.padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
                        .foregroundColor(.secondary)
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(10.0)
                    
                    
                    if showCancelButton  {
                        Button("Cancel") {
                            self.searchMovie = ""
                            self.showCancelButton = false
                        }.foregroundColor(Color(.systemBlue))
                    }
                }.padding(.horizontal)
                .navigationBarHidden(showCancelButton) // Default animasyon
                
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
                                    .foregroundColor(.gray)
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
