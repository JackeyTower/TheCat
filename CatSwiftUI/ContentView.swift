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
            NavigationLink(
                destination: UploadImageView(),
                label: {
                    Text("点我跳转到第二个画面")
                })
        })
        .navigationBarTitle(Text("Person"),displayMode: .inline)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

