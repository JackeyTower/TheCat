//
//  VotedCatImageView.swift
//  CatSwiftUI
//
//  Created by macvm on 2022/5/6.
//

import SwiftUI

//被点赞猫图视图
struct VotedCatImageView: View {
    @ObservedObject var currentData=VotedCatImageViewModel()
    
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

struct VotedCatImageView_Previews: PreviewProvider {
    static var previews: some View {
        VotedCatImageView()
    }
}
