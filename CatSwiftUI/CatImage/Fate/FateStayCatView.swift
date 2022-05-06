//
//  FateStayCat.swift
//  CatSwiftUI
//
//  Created by macvm on 2022/5/6.
//

import SwiftUI

struct FateStayCatView: View {
    @ObservedObject var currentData=FateStayCatViewModel()
    
    var body: some View {
        VStack{
            Text((currentData.breed.name ?? "null"))
            Text((currentData.breed.id ?? "null"))
            Text((currentData.breed.description ?? "null"))
            WebImageView(url: URL(string: currentData.breed.imageURL))
        }
    }
}

struct FateStayCatView_Previews: PreviewProvider {
    static var previews: some View {
        FateStayCatView()
    }
}
