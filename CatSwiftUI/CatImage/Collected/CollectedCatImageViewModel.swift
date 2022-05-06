//
//  CollectedCatImageViewModel.swift
//  CatSwiftUI
//
//  Created by macvm on 2022/5/6.
//

import Foundation

class CollectedCatImageViewModel:ObservableObject {
    @Published var catImageData : [CatImage] = []// 1
    
    init(){
        fetchCollectedCatImage()
    }
}

extension CollectedCatImageViewModel {
    
    func fetchCollectedCatImage() ->(){
        do{
            try SQLiteDataSource.sharedInstance.createTables()
        } catch _{
            print("table already exits")
        }
        do{
            var res=try CatImageDataHelper.findAll()
            for index in 0...(res!.count-1){
                catImageData.append(CatImage(id:res![index].id ,breedId:"",imageURL: res![index].url,breedName: ""))
            }
        }catch _{
            
        }
    }


}
