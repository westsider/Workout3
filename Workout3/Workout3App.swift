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

        init() {
            do {
                modelContainer = try ModelContainer(for: Exercise.self)
            } catch {
                fatalError("Could not initialize ModelContainer")
            }
        }

        var body: some Scene {
            WindowGroup {
                ExerciseGroup()
            }
            .modelContainer(modelContainer)
        }

}
