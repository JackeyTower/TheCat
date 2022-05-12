//
//  ImageSaver.swift
//  CatSwiftUI
//
//  Created by macvm on 2022/5/6.
//

import UIKit
import Alamofire
import SwiftyJSON

//图片保存器
class ImageSaver: NSObject {
    var successHandler: (() -> Void)?
    var errorHandler: ((Error) -> Void)?

    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
    }

    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            errorHandler?(error)
        } else {
            successHandler?()
        }
    }
    
    func uploadCatImage(image:UIImage){
        var json=JSON()
//        var breedData:[Breed2]=Array()
        
        //使用AF来发送http请求，获取响应
        //封装parameters
//        let parameters: Parameters=[
//            "page":page,
//            "limit":20
//        ]
        
        //封装Headers
        let headers: HTTPHeaders = [
            "Content-Type" : "application/x-www-form-urlencoded",
            "x-api-key" : "a8d8adb8-fec8-452a-bd93-dc9f0dba6c74"
        ]
        
        let imageData=image.jpegData(compressionQuality: 0.5)!
        
        //发送请求
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imageData, withName: "file",fileName: "file",mimeType: "image/jpg")
        }, to: "https://api.thecatapi.com/v1/images/upload",headers: headers).response{
            (response) in
            let code=response.response?.statusCode
            if code==201{
                print("success")
            }else{
                print("error")
            }
        }
    }
}
