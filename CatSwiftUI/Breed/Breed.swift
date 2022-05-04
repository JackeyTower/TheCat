//
//  Breed.swift
//  CatSwiftUI
//
//  Created by macvm on 2022/5/1.
//

import SwiftUI
import Alamofire
import SwiftyJSON

import Foundation


// MARK: - Breed
struct Breed: Codable,Hashable,Identifiable {

    
    let adaptability, affectionLevel: Int?
    let altNames: String?
    let cfaURL: String?
    let childFriendly: Int?
    let countryCode, countryCodes, breedDescription: String?
    let dogFriendly, energyLevel, experimental, grooming: Int?
    let hairless, healthIssues, hypoallergenic: Int?
    let id: String?
    let image: Image?
    let indoor, intelligence, lap: Int?
    let lifeSpan, name: String?
    let natural: Int?
    let origin: String?
    let rare: Int?
    let referenceImageID: String?
    let rex, sheddingLevel, shortLegs, socialNeeds: Int?
    let strangerFriendly, suppressedTail: Int?
    let temperament: String?
    let vetstreetURL: String?
    let vocalisation: Int?
    let weight: Weight?
    let wikipediaURL: String?

    enum CodingKeys: String, CodingKey {
        case adaptability
        case affectionLevel = "affection_level"
        case altNames = "alt_names"
        case cfaURL = "cfa_url"
        case childFriendly = "child_friendly"
        case countryCode = "country_code"
        case countryCodes = "country_codes"
        case breedDescription = "description"
        case dogFriendly = "dog_friendly"
        case energyLevel = "energy_level"
        case experimental, grooming, hairless
        case healthIssues = "health_issues"
        case hypoallergenic, id, image, indoor, intelligence, lap
        case lifeSpan = "life_span"
        case name, natural, origin, rare
        case referenceImageID = "reference_image_id"
        case rex
        case sheddingLevel = "shedding_level"
        case shortLegs = "short_legs"
        case socialNeeds = "social_needs"
        case strangerFriendly = "stranger_friendly"
        case suppressedTail = "suppressed_tail"
        case temperament
        case vetstreetURL = "vetstreet_url"
        case vocalisation, weight
        case wikipediaURL = "wikipedia_url"
    }
}

// MARK: - Image
struct Image: Codable ,Hashable{
    let height: Int
    let id: String
    let url: String
    let width: Int
}

// MARK: - Weight
struct Weight: Codable ,Hashable{
    let imperial, metric: String
}


func fetchBreeds(page:Int)->[Breed]{
    //使用AF来发送http请求，获取响应
    //封装parameters
    let parameters: Parameters=[
        "page":page,
        "limit":10
    ]

    //封装Headers
    let headers: HTTPHeaders = [
        "Accept" : "application/json",
        "x-api-key" : "a8d8adb8-fec8-452a-bd93-dc9f0dba6c74"
    ]
    
    //json解析器
    let decoder=JSONDecoder()
    
    var resBreeds:[Breed]?
    //发送请求
    AF.request("https://api.thecatapi.com/v1/breeds"
               ,method: .get
               ,parameters: parameters
               ,headers: headers
    ).responseDecodable(of:[Breed].self,decoder: decoder) { response in
        switch response.result{
        case .success(let breeds):
            resBreeds=breeds
        case .failure(let error):
            print(error)
        }
    }
    return resBreeds!
}


