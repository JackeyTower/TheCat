//
//  FateStayCatViewModel.swift
//  CatSwiftUI
//
//  Created by macvm on 2022/5/6.
//


import Foundation
import Combine
import Alamofire
import SwiftyJSON

//缘分猫品种视图Model
class FateStayCatViewModel: ObservableObject {

    @Published var breed =  Breed(name: "", id: "", imageURL: "", description: "") // 1
    

    init(){
        fetchFateCatBreed()
    }
}

extension FateStayCatViewModel {
    
    //获取缘分猫品种
    func fetchFateCatBreed() ->(){
        var breedName="Abyssinian"
        do{
            var temp=try FateCatBreedDataHelper.findMaxTimesBreedName()
            if temp != nil && temp != "" {
                breedName=temp
            }
        }catch _{
            
        }
        
        var json=JSON()
        //使用AF来发送http请求，获取响应

        //封装Headers
        let headers: HTTPHeaders = [
            "x-api-key" : "a8d8adb8-fec8-452a-bd93-dc9f0dba6c74"
        ]
        
        //封装parameters
        let parameters: Parameters=[
            "q":breedName
        ]
        

        //发送请求
        AF.request("https://api.thecatapi.com/v1/breeds/search"
                   ,method: .get
                   ,parameters: parameters
                   ,headers: headers
        ).response {(response) in
//                debugPrint(response)
                //解析响应的JSON数据
            json=JSON(response.value)
            switch response.result{
                case .success:
                    self.breed=Breed(name: json[0]["name"].stringValue, id: json[0]["id"].stringValue, imageURL: json[0]["image"]["url"].stringValue, description: json[0]["description"].stringValue)
                case .failure(_):
                    print("bug in fetch breeds")
                }
            }
    }


}
