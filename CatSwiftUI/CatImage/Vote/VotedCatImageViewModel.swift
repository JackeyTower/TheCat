//
//  VotedCatImageViewModel.swift
//  CatSwiftUI
//
//  Created by macvm on 2022/5/6.
//

import Foundation

//被点赞猫图视图Model
class VotedCatImageViewModel:ObservableObject {
    @Published var catImageData : [CatImage] = []// 1
    
    init(){
        fetchVotedCatImage()
    }
}

extension VotedCatImageViewModel {
    
    //获取被点赞过的猫图片数据
    func fetchVotedCatImage() ->(){
        do{
            try SQLiteDataSource.sharedInstance.createTables()
        } catch _{
            print("table already exits")
        }
        do{
            var res=try VoteCatImageDataHelper.findAll()
            if res?.count != 0{
                for index in 0...(res!.count-1){
                    catImageData.append(CatImage(id:res![index].id ,breedId:"",imageURL: res![index].url,breedName: ""))
                }
            }
        }catch _{
            
        }
    }


}
