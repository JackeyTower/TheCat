//
//  CollectedCatImageView.swift
//  CatSwiftUI
//
//  Created by macvm on 2022/5/6.
//

import SwiftUI

struct CollectedCatImageView: View {
    @ObservedObject var currentData=CollectedCatImageViewModel()
    
    var body: some View {
        VStack{
            NavigationView{
                List(currentData.catImageData,id:\.id){catImage in
                    NavigationLink(destination:
                                    CatImageDetail(catImage: catImage)){
                        CatImageRow(catImage: catImage)
                    }
                }
            }
        }
    }
}

struct CollectedCatImageView_Previews: PreviewProvider {
    static var previews: some View {
        CollectedCatImageView()
    }
}
