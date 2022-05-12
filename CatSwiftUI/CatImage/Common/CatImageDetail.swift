//
//  CatImageDetail.swift
//  CatSwiftUI
//
//  Created by macvm on 2022/5/5.
//

import SwiftUI

//猫图详情视图
struct CatImageDetail: View {
    var catImage: CatImage
    @State var collected=false
    var body: some View {
        VStack{
            //            WebImageView(url: URL(string: catImageViewModel.catImage.imageURL))
            CatImageView(imageUrl: catImage.imageURL)
            Button("Collect It"){
                do{
                    try SQLiteDataSource.sharedInstance.createTables()
                } catch _{
                    
                }
                do {
                    //查找是否已收藏过
                    var res=try CatImageDataHelper.find(findId: catImage.id)
                    
                    //如果没有收藏过，进行收藏操作
                    if res == nil{
                        do{
                            try! CatImageDataHelper.insert(item: CollectedCatImage(id:catImage.id,url:catImage.imageURL))
                            
                        }catch _{
                            
                        }
                    }else{
                        collected=true
                    }
                }catch _{
                    
                }
                
            }.alert(isPresented: $collected){
                Alert(title: Text("已收藏"),
                      message: Text("您已收藏过此猫"),
                      dismissButton: .default(Text("OK")))
            }
        }
    }
}

//struct CatImageDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        CatImageDetail()
//    }
//}
