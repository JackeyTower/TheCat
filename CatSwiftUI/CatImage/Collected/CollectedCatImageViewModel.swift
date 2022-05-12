//
//  CollectedCatImageViewModel.swift
//  CatSwiftUI
//
//  Created by macvm on 2022/5/6.
//

import Foundation

//被收藏的猫图视图Model
class CollectedCatImageViewModel:ObservableObject {
    @Published var catImageData : [CatImage] = []// 1
    
    init(){
        fetchCollectedCatImage()
    }
}

extension CollectedCatImageViewModel {
    
    //获取被收藏的猫图数据
    func fetchCollectedCatImage() ->(){
        do{
            try SQLiteDataSource.sharedInstance.createTables()
        } catch _{
            print("table already exits")
        }
        do{
            var res=try CatImageDataHelper.findAll()
            if res?.count != 0{
                for index in 0...(res!.count-1){
                    catImageData.append(CatImage(id:res![index].id ,breedId:"",imageURL: res![index].url,breedName: ""))
                }
            }
        }catch _{
            
        }
    }


}
