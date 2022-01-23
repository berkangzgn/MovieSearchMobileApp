//
//  MovieViewModel.swift
//  MovieSearchMobileApp
//
//  Created by Berkan Gezgin on 22.01.2022.
//

import Foundation
import SwiftUI

// ----- Gözlemlenebilir obje ------
class MovieArrayViewModel : ObservableObject {
    // ObservableObject : Kombine framework'ün içerisinde bir tiptir. Bu tiple birlikte yayıncı durumuna sokarız. View'lerden bu yayına subsucribe olarak görünümleri view üstüne çekebilliriz.
    
    @Published var movies = [MovieViewModel]()
        let downloaderClient = DownloaderClient()
        func doMovieSearch(movieName : String) {
            downloaderClient.downloadMovies(search: movieName) { (result) in
                switch result {
                    case.failure(let error):
                        print(error)
                    case .success(let movieArray):
                        if let movieArray = movieArray {
                            DispatchQueue.main.async {
                        // Kullanıcı görünümünde işlem yaptığımız için donmamsı adına işlemlerimizi async yapıyoruz
                        self.movies = movieArray.map(MovieViewModel.init)
                        // map ile tür dönüşümü yaptık. Önceden 14. satırda MovieViewModel modeli yerine Movie modeli vardı
                    }
                }
            }
        }
    }
}

struct MovieViewModel {
    let movie : Movie
    var title : String { movie.title }
    var poster : String { movie.poster }
    var year : String { movie.year }
    var imdbID : String { movie.imdbID }
}
