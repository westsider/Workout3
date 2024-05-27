//
//  ContentView.swift
//  Workout3
//
//  Created by Warren Hansen on 5/25/24.
//
//  Created by Warren Hansen on 5/25/24.
//  X make a list of Bench, curls, fly's, lig lift,
//  X items incluse num reps, weight and completed
//  X ui has each item and num reps completed
//  X toggle set completed
//  X create aonther workout goup
//  X step weight
//  X main screen
//  X nav to exercise screen

//  when all completed return to main and show last workout
//  list all workouts in main
//  persist values

import SwiftUI
import SwiftData

struct ExerciseGroup: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query private var exercise: [Exercise]
    let dataLoader =  DataLoader()
    let groupName: String
    
    @Query(filter: #Predicate<Exercise> { exercises in
        exercises.group == "Group A"
    }) var movies: [Exercise]

    init(groupName: String) {
        self.groupName = groupName
            _movies = Query(filter: #Predicate<Exercise> { exercises in
                exercises.group == groupName
            })
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(groupName).font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            List(movies)  { this in
                Section(header: Text(this.name)) {
                    ExerciseReps(exercise: this)
                    
                }.headerProminence(.increased)
            }
        }.onAppear() {
            loadExercises()
        }
        .padding()
    }
    
    private func loadExercises() {
        if exercise.isEmpty {
            firstRun()
        }
    }
    
    private func firstRun() {
        for item in dataLoader.GroupA() {
            modelContext.insert(item)
        }
        
        for item in dataLoader.GroupB() {
            modelContext.insert(item)
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Exercise.self, configurations: config)
    let dataLoader =  DataLoader()
    for item in dataLoader.GroupA() {
        container.mainContext.insert(item)
    }
    return ExerciseGroup(groupName: "Group A")
        .modelContainer(container)
}
