//
//  ImageDownloaderClient.swift
//  MovieSearchMobileApp
//
//  Created by Berkan Gezgin on 23.01.2022.
//

import Foundation

class ImageDownloaderClient : ObservableObject{
// İndirildiğini görünümlere belirteceğimiz için bu sınıfın ObservableObject olması gerekli
    
    @Published var downloadedImage : Data?
    // Sınıfımız ObservableObject olduğu için değişkenimizi görünütülenebilir yaptık
    
    func downloadImage(url: String) {
        guard let imageUrl = URL(string: url) else {
            return
        }
        
        URLSession.shared.dataTask(with: imageUrl) { (data, response, error) in
            guard let data = data, error == nil else {
                return
            }
            
            // Kullanıcı donma problemleri yaşamaması için işlemimizi async olarak işliyoruz
            DispatchQueue.main.async {
                self.downloadedImage = data
            }
        }.resume()
    }
}
