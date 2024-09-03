//
//  PinterestDummyApp.swift
//  PinterestDummy
//
//  Created by Lnu, Karan on 8/10/24.
//

import SwiftUI
import SwiftData
import Kingfisher

@main
struct PinterestDummyApp: App {
//    var sharedModelContainer: ModelContainer = {
//        let schema = Schema([
//            Item.self,
//        ])
//        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
//
//        do {
//            return try ModelContainer(for: schema, configurations: [modelConfiguration])
//        } catch {
//            fatalError("Could not create ModelContainer: \(error)")
//        }
//    }()
    

    var body: some Scene {
        
        WindowGroup {

            HomeScreen()
        }
//        .modelContainer(sharedModelContainer)
    }
}
