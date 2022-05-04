//
//  WebImageView.swift
//  CatSwiftUI
//
//  Created by macvm on 2022/5/1.
//

import SwiftUI
import SDWebImageSwiftUI

struct WebImageView: View {

    let url: URL?
    @State var isAnimating: Bool = true
    var body: some View {
        VStack {
            WebImage(url: url)
                .placeholder{Color.gray}
                .resizable()
                .onSuccess(perform: { _, _, _ in
                    print("Success")
                    SDWebImageManager.shared.imageCache.clear(with: .all, completion: nil)//清除图片缓存
                })
                .onFailure(perform: { _ in
                    print("Failure")
                })
                .scaledToFit()
                .frame(height:300)
                .clipped()
            
//            WebImage(url: URL(string: "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fhbimg.b0.upaiyun.com%2Fd24885b5b1a6643685ddba5bda3b17866b6c614c33fbd-XtBuP4_fw658&refer=http%3A%2F%2Fhbimg.b0.upaiyun.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1630205128&t=1964ae7a79ad3fcb3d4ca970b19b53b9"), isAnimating: $isAnimating) // 支持动图
//                .customLoopCount(.max) // 播放次数
//                .playbackRate(1.0) // 播放速度
//                .playbackMode(.normal)
        }
    }
}

struct WebImageViewPreview: PreviewProvider {
    static var previews: some View {
        var url = URL(string: "https://cdn2.thecatapi.com/images/5AdhMjeEu.jpg")!
        WebImageView(url: url)
    }
}



