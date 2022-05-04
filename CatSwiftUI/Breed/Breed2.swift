//
//  Breed2.swift
//  CatSwiftUI
//
//  Created by macvm on 2022/5/3.
//

import Foundation
import Alamofire
import SwiftyJSON

// MARK: - Breed
struct Breed2 :Identifiable{

    var name:String
    var id:String
    var imageURL:String
    var description:String

}

//func fetchBreeds2(page:Int) ->[Breed2]{
//
//    var json=JSON()
//    var breedData:[Breed2]=Array()
//
//    //使用AF来发送http请求，获取响应
//    //封装parameters
//    let parameters: Parameters=[
//        "page":1,
//        "limit":2
//    ]
//
//    //封装Headers
//    let headers: HTTPHeaders = [
//        "Accept" : "application/json",
//        "x-api-key" : "a8d8adb8-fec8-452a-bd93-dc9f0dba6c74"
//    ]
//
//    //发送请求
//
//    AF.request("https://api.thecatapi.com/v1/breeds"
//               ,method: .get
//               ,parameters: parameters
//               ,headers: headers
//    ).response { (response) in
//    //            debugPrint(response)
//            //解析响应的JSON数据
//            json=JSON(response.value)
//            switch response.result{
//            case .success:
//                for i in 0..<2 {
//                    print("\(json[i]["id"])")
//                    var breed2=Breed2(name: json[i]["name"].stringValue, id: json[i]["id"].stringValue, imageURL: json[i]["image"]["url"].stringValue, description: json[i]["description"].stringValue)
//                    print("\(breed2.id)")
//                    breedData.append(breed2)
//                    print("\(breedData.count)")
//                }
//            case .failure(_):
//                print("bug")
//            }
//
//        }
//
//}
