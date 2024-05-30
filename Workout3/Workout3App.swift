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

//    let schema = Schema([Exercise.self, Historical.self])
//    let configuration = ModelConfiguration(inMemory: true)
//    let container = try! ModelContainer(for: schema, configurations: [configuration])
    
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
            }
            .modelContainer(modelContainer)
        }

}
