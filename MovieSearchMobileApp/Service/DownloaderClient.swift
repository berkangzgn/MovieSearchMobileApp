//
//  DownloaderClient.swift
//  MovieSearchMobileApp
//
//  Created by Berkan Gezgin on 22.01.2022.
//

import Foundation

struct DownloaderClient {
    // Movies Search
    func downloadMovies(search : String, completion : @escaping (Result<[Movie]?,DownloaderError> ) -> Void) {
        // MainThread'i durdurmaması için Async çalışması gerekiyor.
        // Result bize ya success ya fail verir.
        
        // URL hatasını kontrol ediyoruz
        guard let url = URL(string: "http://www.omdbapi.com/?s=\(search)&apikey=f993ef3a") else {
            return completion(.failure(.wrongUrl))
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            // Hata boş dönüyorsa veri gelmemiştir, burada onu kontrol ettik
            guard let data = data, error == nil else {
                return completion(.failure(.dataDidntCome))
            }
             
            // IncomingMovies bir movie dizisidir. CodingKey search anahtar kelimesiydi. Karşısında da JSon bir sonuç bekleyecek. Biz bu diziyi decode ediyoruz
            guard let movieResponse = try? JSONDecoder().decode(IncomingMovies.self, from: data) else {
                return completion(.failure(.dataCouldntProcessed))
            }
        
            completion(.success(movieResponse.movies))
        }.resume()
    }
    
    
    // Movie Detail
    func downloadMovieDetail(imdbID : String, completion: @escaping (Result<MovieDetail,DownloaderError>) -> Void) {
        // Artık arama değil görüntüleme yaptığımız için =\(imdbID)'dan önce s değil i anahtar harfini kullandık
        guard let url = URL(string: "https://www.omdbapi.com/?i=\(imdbID)&apikey=f993ef3a") else {
            return completion(.failure(.wrongUrl))
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                return completion(.failure(.dataDidntCome))
            }
            
            guard let giveMovieDetail = try? JSONDecoder().decode(MovieDetail.self, from: data) else {
                return completion(.failure(.dataCouldntProcessed))
            }

            completion(.success(giveMovieDetail))
        }.resume()
    }
}

enum DownloaderError : Error {
    case wrongUrl
    case dataDidntCome
    case dataCouldntProcessed
}
