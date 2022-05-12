//
//  Breed2.swift
//  CatSwiftUI
//
//  Created by macvm on 2022/5/3.
//

import Foundation
import Alamofire
import SwiftyJSON

//猫种类结构体
struct Breed :Identifiable{

    var name:String
    var id:String
    var imageURL:String
    var description:String

}

