//
//  BreedDetail.swift
//  CatSwiftUI
//
//  Created by macvm on 2022/5/1.
//

import SwiftUI

//种类详情视图
struct BreedDetail: View {
    var breed: Breed2
    var body: some View {
        VStack{
            Text((breed.name ?? "null"))
            Text((breed.id ?? "null"))
            Text((breed.description ?? "null"))
            WebImageView(url: URL(string: breed.imageURL))
        }
    }
}

//struct BreedDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        BreedDetail(breed: breedData[1])
//    }
//}
