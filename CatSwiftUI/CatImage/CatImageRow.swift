//
//  CatImageRow.swift
//  CatSwiftUI
//
//  Created by macvm on 2022/5/5.
//

import SwiftUI

struct CatImageRow: View {
    var catImage:CatImage
    
    var body: some View {
        HStack{
            CatImageView(imageUrl:catImage.imageURL)
            Spacer()
            Text((catImage.id ?? "null"))
        }
    }
}

//struct CatImageRow_Previews: PreviewProvider {
//    static var previews: some View {
//        CatImageRow()
//    }
//}
