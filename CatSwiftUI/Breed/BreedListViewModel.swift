//
//  BreedListViewModel.swift
//  CatSwiftUI
//
//  Created by macvm on 2022/5/4.
//


import Foundation
import Combine
import Alamofire
import SwiftyJSON

//种类列表视图Model
class BreedListViewModel: ObservableObject {

    @Published var breedDataList: [Breed] = [] // 1

    init(){
        fetchBreeds(page: 1)
    }
}

extension BreedListViewModel {
    
    //获取品种列表数据
    func fetchBreeds(page:Int) ->(){
        
        var json=JSON()
        var breedData:[Breed]=Array()
        
        //使用AF来发送http请求，获取响应
        //封装parameters
        let parameters: Parameters=[
            "page":page,
            "limit":20
        ]

        //封装Headers
        let headers: HTTPHeaders = [
            "Accept" : "application/json",
            "x-api-key" : "a8d8adb8-fec8-452a-bd93-dc9f0dba6c74"
        ]
        
        //发送请求
       
        AF.request("https://api.thecatapi.com/v1/breeds"
                   ,method: .get
                   ,parameters: parameters
                   ,headers: headers
        ).response { (response) in
        //            debugPrint(response)
                //解析响应的JSON数据
                json=JSON(response.value)
                switch response.result{
                case .success:
                    for i in 0..<20 {
                        print("\(json[i]["id"])")
                        var breed2=Breed(name: json[i]["name"].stringValue, id: json[i]["id"].stringValue, imageURL: json[i]["image"]["url"].stringValue, description: json[i]["description"].stringValue)
                        print("\(breed2.id)")
                        breedData.append(breed2)
                        print("\(breedData.count)")
                    }
                    self.breedDataList=breedData
                case .failure(_):
                    print("bug in fetch breeds")
                }

            }
    }


}
