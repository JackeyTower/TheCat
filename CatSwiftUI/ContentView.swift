//
//  ContentView.swift
//  CatSwiftUI
//
//  Created by macvm on 2022/5/1.
//

import SwiftUI
import CoreData

struct ContentView: View {

    var body: some View {
        NavigationView(content: {
            VStack{
                NavigationLink(
                    destination: RandomCatImageView(),
                    label: {
                        Text("随机猫图")
                    })
                NavigationLink(
                    destination: AllCatImageView(),
                    label: {
                        Text("所有猫图")
                    })
                NavigationLink(
                    destination: BreedList(),
                    label: {
                        Text("种类")
                    })
                NavigationLink(
                    destination: CollectedCatImageView(),
                    label: {
                        Text("收藏的猫图")
                    })
                NavigationLink(
                    destination: VotedCatImageView(),
                    label: {
                        Text("点赞的猫图")
                    })
                NavigationLink(
                    destination: UploadImageView(),
                    label: {
                        Text("上传猫图")
                    })
                NavigationLink(
                    destination: FateStayCatView(),
                    label: {
                        Text("缘分品种")
                    })
            }

        })
        .navigationBarTitle(Text("Person"),displayMode: .inline)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

