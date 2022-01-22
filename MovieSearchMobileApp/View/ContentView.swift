//
//  ContentView.swift
//  MovieSearchMobileApp
//
//  Created by Berkan Gezgin on 22.01.2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Button( action: {
            DownloaderClient().downloadMovies(search: "titanic") { (result) in
                switch result {
                case .success(let movieArray) : print(movieArray)
                case .failure(let error) : print(error)
                }
            }
        }, label: {
            Text("Start Test")
        })

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
