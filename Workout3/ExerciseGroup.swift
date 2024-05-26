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
//  toggle set completed
//  when all completed return to main and show last workout
//  list all workouts in main
import SwiftUI
import SwiftData

@Model
final class Exercise {
    var group: String
    var name: String
    var numReps: Int
    var numSets: Int
    var weight: Int
    var completed: Bool
    
    init(group: String, name: String, numReps: Int, numSets: Int, weight: Int, completed: Bool) {
        self.group = group
        self.name = name
        self.numReps = numReps
        self.numSets = numSets
        self.weight = weight
        self.completed = completed
    }
}

class DataLoader {
    func firstRun() -> [Exercise] {
        let exercise1 = Exercise(group: "Group A", name: "Bench", numReps: 8, numSets: 4, weight: 135, completed: false)
        
        let exercise2 = Exercise(group: "Group A", name: "Curls", numReps: 8, numSets: 3, weight: 50, completed: false)
        
        let exercise3 = Exercise(group: "Group A", name: "Fly's", numReps: 8, numSets: 4, weight: 40, completed: false)
        
        let exercise4 = Exercise(group: "Group A", name: "Leg Lifts", numReps: 8, numSets: 3, weight: 0, completed: false)
        var exercises: [Exercise] = []
        exercises.append(exercise1)
        exercises.append(exercise2)
        exercises.append(exercise3)
        exercises.append(exercise4)
        return exercises
    }
}

struct ExerciseReps: View {
    var exercise: Exercise
    var body: some View {
        VStack {
            ForEach(1...exercise.numSets, id: \.self) { num in
                HStack {
                    Text("\(num)")
                    Spacer()
                    Text("\(exercise.weight) lbs")
                    Spacer()
                    Text("\(exercise.numReps) Reps")
                    Spacer()
                    Image(systemName: "star")
                }
            }
        }
    }
}
struct ExerciseGroup: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query private var exercise: [Exercise]
    let dataLoader =  DataLoader()
    
    var body: some View {
        
        VStack {
            Text(exercise.first?.group ?? "no Group").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            List(exercise)  { this in
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
        for item in dataLoader.firstRun() {
            modelContext.insert(item)
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Exercise.self, configurations: config)
    let dataLoader =  DataLoader()
    for item in dataLoader.firstRun() {
        container.mainContext.insert(item)
    }
    return ExerciseGroup()
        .modelContainer(container)
}
