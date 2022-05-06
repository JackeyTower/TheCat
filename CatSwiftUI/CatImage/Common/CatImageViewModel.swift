//
//  CatImageViewModel.swift
//  CatSwiftUI
//
//  Created by macvm on 2022/5/4.
//
import Foundation
import Combine
import Alamofire
import SwiftyJSON

//猫图片视图model
class CatImageViewModel: ObservableObject {

    @Published var catImage = CatImage(id:"0",breedId:"0",imageURL:"0",breedName: "") // 1
    

    init(){
        fetchRandomCatImage()
    }
}

extension CatImageViewModel {
    
    func fetchRandomCatImage() ->(){
        
        var json=JSON()
        var breedData:[Breed2]=Array()
        
        //使用AF来发送http请求，获取响应

        //封装Headers
        let headers: HTTPHeaders = [
            "Accept" : "application/json",
            "x-api-key" : "a8d8adb8-fec8-452a-bd93-dc9f0dba6c74"
        ]
        
        //发送请求
       
        AF.request("https://api.thecatapi.com/v1/images/search"
                   ,method: .get
                   ,headers: headers
        ).response { (response) in
        //            debugPrint(response)
                //解析响应的JSON数据
                json=JSON(response.value)
                switch response.result{
                case .success:
                    self.catImage=CatImage( id: json[0]["id"].stringValue,breedId: json[0]["breeds"][0]["id"].stringValue, imageURL: json[0]["url"].stringValue,breedName: json[0]["breeds"][0]["name"].stringValue)
                case .failure(_):
                    print("bug in fetch breeds")
                }

            }
    }


}
