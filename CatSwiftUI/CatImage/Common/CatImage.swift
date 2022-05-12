//
//  CatImage.swift
//  CatSwiftUI
//
//  Created by macvm on 2022/5/4.
//

import Foundation
import Alamofire
import SwiftyJSON

//猫图结构体
struct CatImage:Identifiable{
    var id:String
    var breedId:String
    var imageURL:String
    var breedName:String
}
