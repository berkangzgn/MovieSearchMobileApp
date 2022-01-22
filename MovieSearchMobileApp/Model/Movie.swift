//
//  Movie.swift
//  MovieSearchMobileApp
//
//  Created by Berkan Gezgin on 22.01.2022.
//

// Eğer API'ler ile çalışırken gelen response'u çözemezsek json4swift gibi sitelerden API'ı anlamlı hale getirip çalışabiliriz.

import Foundation

struct Movie : Codable { // API üzerinden çektiğimiz bilgileri işleyip değişkenlere atamamıza olanak sağlar
    // Decodable : Gelen veriyi yapıya çevirmek için
    // Encodable : Yapıyı veriye çevirmek için
    
    let title : String
    let year : String
    let imdbID : String
    let type : String
    let poster : String
    
    private enum CodingKeys : String, CodingKey {
        // Gelen veride değişken isimleri büyük harfle başladığı için biz bu değişken isimlerini küçük harfe döndürüyoruz.
        case title = "Title"
        case year = "Year"
        case type = "Type"
        case poster = "Poster"
    }
}

struct IncomingMovies : Codable {
    // API'den gelen bilgiler dizi içerisine almamız gerekiyor. Ayrıca gelen ilk cevap Search anahtar kelimesi ile geliyor.
    
    let movies : [Movie]
    
    private enum CodingKeys : String, CodingKey {
        case movies = "Search"
    }
}
