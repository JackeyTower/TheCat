//
//  FateStayCat.swift
//  CatSwiftUI
//
//  Created by macvm on 2022/5/6.
//

import SwiftUI

//缘分猫品种视图
struct FateStayCatView: View {
    //当前视图的数据
    @ObservedObject var currentData=FateStayCatViewModel()
    
    var body: some View {
        VStack{
            Text((currentData.breed.name ?? "null"))
            Text((currentData.breed.id ?? "null"))
            Text((currentData.breed.description ?? "null"))
        }
    }
}

struct FateStayCatView_Previews: PreviewProvider {
    static var previews: some View {
        FateStayCatView()
    }
}
