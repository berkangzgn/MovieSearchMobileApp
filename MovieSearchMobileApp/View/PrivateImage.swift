//
//  PrivateImage.swift
//  MovieSearchMobileApp
//
//  Created by Berkan Gezgin on 22.01.2022.
//

import SwiftUI

struct PrivateImage: View {
    
    let url : String
    @ObservedObject var imageDownloaderClient = ImageDownloaderClient()
    // ImageDownloaderclient üzerinden publish ettiğimiz veriyi burada @ObservedObject ile gözlemlenebilir kılıyoruz.
    
    init(url:String) {
        self.url = url
        self.imageDownloaderClient.downloadImage(url: self.url)
    }
    
    // URL üzerinden gelen image'ı işliyoruz. eğer gelmezse default olarak placeholder görselimizi veriyoruz.
    var body: some View {
        if let data = self.imageDownloaderClient.downloadedImage {
            return Image(uiImage: UIImage(data: data)!)
                .resizable()
        } else {
            return Image("placeholder")
                .resizable()
        }
    }
}

struct PrivateImage_Previews: PreviewProvider {
    static var previews: some View {
        PrivateImage(url: "https://m.media-amazon.com/images/M/MV5BMDdmZGU3NDQtY2E5My00ZTliLWIzOTUtMTY4ZGI1YjdiNjk3XkEyXkFqcGdeQXVyNTA4NzY1MzY@._V1_SX300.jpg")
    
            
    }
}
