//
//  Workout3App.swift
//  Workout3
//
//  Created by Warren Hansen on 5/25/24.
//

import SwiftUI
import SwiftData

@main
struct Workout3App: App {
    
    let modelContainer: ModelContainer
   // @StateObject var manager = HealthManager()
    
    init() {
        do {
            modelContainer = try ModelContainer(for: Exercise.self, Historical.self)
        } catch {
            fatalError("Could not initialize ModelContainer")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            MainTabBar()
                //.environmentObject(manager)
        }
        .modelContainer(modelContainer)
    }
    
}
