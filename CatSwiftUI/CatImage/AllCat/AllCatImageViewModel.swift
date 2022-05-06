//
//  AllCatImageViewModel.swift
//  CatSwiftUI
//
//  Created by macvm on 2022/5/5.
//

import Foundation
import Combine
import Alamofire
import SwiftyJSON

class AllCatImageViewModel:ObservableObject {
    @Published var catImageData : [CatImage] = []// 1
    
    init(){
        fetchAllCatImage(page:1)
    }
}

extension AllCatImageViewModel {
    
    func fetchAllCatImage(page:Int) ->(){
        
        var json=JSON()
        var catImageData:[CatImage]=Array()
        
        //使用AF来发送http请求，获取响应
        //封装parameters
        let parameters: Parameters=[
            "page":page,
            "limit":2
        ]

        //封装Headers
        let headers: HTTPHeaders = [
            "Accept" : "application/json",
            "x-api-key" : "a8d8adb8-fec8-452a-bd93-dc9f0dba6c74"
        ]
        
        //发送请求
       
        AF.request("https://api.thecatapi.com/v1/images/search"
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
                        var catImage=CatImage( id: json[i]["id"].stringValue,breedId: json[i]["breeds"][0]["id"].stringValue, imageURL: json[i]["url"].stringValue,breedName: json[i]["breeds"][0]["name"].stringValue)
                        catImageData.append(catImage)
                    }
                    self.catImageData=catImageData
                case .failure(_):
                    print("bug in fetch all catImages")
                }

            }
    }


}
