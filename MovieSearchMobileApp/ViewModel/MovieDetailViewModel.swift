//
//  MovieDetailViewModel.swift
//  MovieSearchMobileApp
//
//  Created by Berkan Gezgin on 22.01.2022.
//

import Foundation
import SwiftUI


class MovieDetailViewModel : ObservableObject {
    
    @Published var movieDetail : MovieDetailsViewModel?
    
    let downloaderClient = DownloaderClient()

    func giveMovieDetail(imdbID : String) {
        downloaderClient.downloadMovieDetail(imdbID: imdbID) { (result) in
            switch result {
            case .failure(let result):
                print(result)
            case .success(let movieDetail):
                DispatchQueue.main.async {
                    self.movieDetail = MovieDetailsViewModel(detail: movieDetail)
                }
            }
        }
    }
}

struct MovieDetailsViewModel {
    let detail : MovieDetail
    
    var title : String { detail.title }
    var poster : String { detail.poster }
    var year : String { detail.year }
    var imdbID : String { detail.imdbID }
    var director : String { detail.director }
    var writer : String { detail.writer }
    var awards : String { detail.awards }
    var plot : String { detail.plot }
}
