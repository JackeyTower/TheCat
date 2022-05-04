//
//  CatSwiftUIApp.swift
//  CatSwiftUI
//
//  Created by macvm on 2022/5/1.
//

import SwiftUI

@main
struct CatSwiftUIApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
