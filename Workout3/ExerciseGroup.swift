//
//  ContentView.swift
//  Workout3
//
//  Created by Warren Hansen on 5/25/24.
//


import SwiftUI
import SwiftData

struct ExerciseGroup: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext
    @Query private var exercise: [Exercise]
    let dataLoader =  DataLoader()
    let groupName: String
    @State var completed = 0
    
    @Query(filter: #Predicate<Exercise> { exercises in
        exercises.group == "Group A"
    }) var exercises: [Exercise]
    
    init(groupName: String) {
        self.groupName = groupName
        _exercises = Query(filter: #Predicate<Exercise> { exercisesS in
            exercisesS.group == groupName
        })
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(groupName).font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            List(exercises)  { this in
                Section(header: Text(this.name)) {
                    ExerciseReps(id: this.id)
                }.headerProminence(.increased)
                    .foregroundStyle(this.completed ? .blue : .primary)
                    .onChange(of: this.completed) { newValue in
                        completed = 0
                        for each in exercise {
                            if each.completed {
                                completed += 1
                            }
                        }
                        print("completed = \(completed) of \(exercises.count) exercises")
                        // if that is all of them >
                        if completed == exercises.count {
                            print("Workout Complete")
                            dismiss()
                            // 1. reset the completed vars
                            // 2. update date  on last workout
                            for each in exercises {
                                each.completed = false
                                each.date = Date()
                            }
                        }
                    }
            }
            
        }.onAppear() {
            //loadExercises()
        }
        .padding()
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Exercise.self, configurations: config)
    let dataLoader =  DataLoader()
    for item in dataLoader.GroupA() {
        container.mainContext.insert(item)
    }
    
    for item in dataLoader.GroupB() {
        container.mainContext.insert(item)
    }
    
    for item in dataLoader.GroupC() {
        container.mainContext.insert(item)
    }
    
    for item in dataLoader.GroupD() {
        container.mainContext.insert(item)
    }
    
    for item in dataLoader.stretch() {
        container.mainContext.insert(item)
    }
    return ExerciseGroup(groupName: "stretch")
        .modelContainer(container)
}
