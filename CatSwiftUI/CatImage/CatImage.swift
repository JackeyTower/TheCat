//
//  CatImage.swift
//  CatSwiftUI
//
//  Created by macvm on 2022/5/4.
//

import Foundation
import Alamofire
import SwiftyJSON

// MARK: - Breed
struct CatImage:Identifiable{
    var id:String
    var breedId:String
    var imageURL:String

}
