//
//  DeatilView.swift
//  MovieSearchMobileApp
//
//  Created by Berkan Gezgin on 22.01.2022.
//

import SwiftUI


struct DetailView: View {
    
    let imdbID : String
    
    @ObservedObject var movieDetailViewModel = MovieDetailViewModel()
    
    var body: some View {
        VStack(alignment:.leading, spacing:5){
            HStack{
                Spacer()
                PrivateImage(url: movieDetailViewModel.movieDetail?.poster ?? "").frame(width: UIScreen.main.bounds.width * 0.6, height: UIScreen.main.bounds.height * 0.3, alignment: .center)
                Spacer()
            }
            
            Text(movieDetailViewModel.movieDetail?.title ?? "Film Ismi Gösterilecek").font(.title).foregroundColor(.blue).padding()
            
            Text(movieDetailViewModel.movieDetail?.plot ?? "Film Plotu Gösterilecek").padding()
            
            Text("Yönetmen: \(movieDetailViewModel.movieDetail?.director ?? "Yönetmen Gösterilecek")").padding()
            
            Text("Yazar: \(movieDetailViewModel.movieDetail?.writer ?? "Yazar Gösterilecek")").padding()
            
            Text("Ödüller: \(movieDetailViewModel.movieDetail?.awards ?? "Ödüller Gösterilecek")").padding()
            
            Text("Yıl: \(movieDetailViewModel.movieDetail?.year ?? "Yıl Gösterilecek")").padding()
            
            Spacer()
            
        }.onAppear(perform: {
            self.movieDetailViewModel.giveMovieDetail(imdbID: imdbID)
        })
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(imdbID: "test")
    }
}
