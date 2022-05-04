//
//  CatImageView.swift
//  CatSwiftUI
//
//  Created by macvm on 2022/5/4.
//

import SwiftUI

//猫图片视图
struct CatImageView: View {
    @ObservedObject var catImageViewModel=CatImageViewModel()
    
    var body: some View {
        VStack{
            Button("Random Cat"){
                catImageViewModel.fetchRandomCatImage()
            }
            WebImageView(url: URL(string: catImageViewModel.catImage.imageURL))
        }
    }
}

struct CatImageView_Previews: PreviewProvider {
    static var previews: some View {
        CatImageView()
    }
}
