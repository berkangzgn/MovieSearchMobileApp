//
//  MovieDetail.swift
//  MovieSearchMobileApp
//
//  Created by Berkan Gezgin on 22.01.2022.
//

import Foundation


struct MovieDetail : Codable {
    
    let title : String
    let year : String
    let genre : String
    let director : String
    let writer : String
    let actors : String
    let plot : String
    let awards : String
    let poster : String
    let metascore : String
    let imdbRating : String
    let imdbID : String
    
    private enum CodingKeys : String, CodingKey {
        case title = "Title"
        case year = "Year"
        case genre = "Genre"
        case director = "Director"
        case writer = "Writer"
        case actors = "Actors"
        case plot = "Plot"
        case awards = "Awards"
        case poster = "Poster"
        case metascore = "Metascore"
        case imdbRating = "imdbRating"
        case imdbID = "imdbID"
    }
    
}
