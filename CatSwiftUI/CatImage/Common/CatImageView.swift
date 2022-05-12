//
//  CatImageView.swift
//  CatSwiftUI
//
//  Created by macvm on 2022/5/5.
//

import SwiftUI

//猫图视图
struct CatImageView: View {
    var imageUrl: String
    
    var body: some View {
        WebImageView(url: URL(string: imageUrl))
    }
}

//struct CatImageView_Previews: PreviewProvider {
//    static var previews: some View {
//        CatImageView()
//    }
//}
