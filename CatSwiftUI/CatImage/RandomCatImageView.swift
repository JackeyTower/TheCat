//
//  CatImageView.swift
//  CatSwiftUI
//
//  Created by macvm on 2022/5/4.
//

import SwiftUI

//随机猫图片视图
struct RandomCatImageView: View {
    @ObservedObject var catImageViewModel=CatImageViewModel()
    
    var body: some View {
        VStack{
            Button("Random Cat"){
                catImageViewModel.fetchRandomCatImage()
            }
//            WebImageView(url: URL(string: catImageViewModel.catImage.imageURL))
            CatImageView(imageUrl: catImageViewModel.catImage.imageURL)
            Button("Collect It"){
                do{
                    try SQLiteDataSource.sharedInstance.createTables()
                } catch _{
                    
                }
                do{
                    var res=try CatImageDataHelper.find(findId: catImageViewModel.catImage.id)
                    try! CatImageDataHelper.insert(item: CollectedCatImage(id:catImageViewModel.catImage.id,url:catImageViewModel.catImage.imageURL))
                }catch _{
                    
                }
            }
        }
    }
}

struct CatImageView_Previews: PreviewProvider {
    static var previews: some View {
        RandomCatImageView()
    }
}
