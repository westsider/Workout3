//
//  ContentView.swift
//  Workout3
//
//  Created by Warren Hansen on 5/25/24.
//
//  Created by Warren Hansen on 5/25/24.
//  make a list of Bench, curls, fly's, lig lift,
//  items incluse num reps, weight and completed

//  ui has each item and num reps completed
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
        
        let exercise2 = Exercise(group: "Group A", name: "Curls", numReps: 8, numSets: 4, weight: 50, completed: false)
        
        let exercise3 = Exercise(group: "Group A", name: "Fly's", numReps: 8, numSets: 4, weight: 40, completed: false)
        
        let exercise4 = Exercise(group: "Group A", name: "Leg Lifts", numReps: 8, numSets: 4, weight: 0, completed: false)
        var exercises: [Exercise] = []
        exercises.append(exercise1)
        exercises.append(exercise2)
        exercises.append(exercise3)
        exercises.append(exercise4)
        return exercises
        
    }
}

// todo loop through reps and fill in details
struct TaskRow: View {
    var exercise: Exercise
    var body: some View {
        
        let numSets = 1...exercise.numSets
        VStack {
            ForEach(numSets, id: \.self) { i in
                HStack {
                    Text("\(i)")
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
struct ContentView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query private var exercise: [Exercise]
    @State var text: String = "Hello World!"
    let dataLoader =  DataLoader()
    
    var body: some View {
        
        VStack {
            Text(exercise.first?.group ?? "no Group").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            
            
            List(exercise)  { this in
                //Text($0.name)
                Section(header: Text(this.name)) {
                    TaskRow(exercise: this)
//                    TaskRow()
//                    TaskRow()
                    
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
        } else {
            text = "You have \(exercise.count) exercises"
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
    return ContentView()
        .modelContainer(container)
}
