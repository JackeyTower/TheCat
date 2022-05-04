//
//  BreedRow.swift
//  CatSwiftUI
//
//  Created by macvm on 2022/5/2.
//

import SwiftUI

//种类列表行识图
struct BreedRow: View {
    var breed:Breed2
    
    var body: some View {
        HStack{
            Text((breed.name ?? "null"))
            Spacer()
        }
    }
}

//struct BreedRow_Previews: PreviewProvider {
//    static var previews: some View {
//        BreedRow(breed: breedData[0])
//    }
//}
