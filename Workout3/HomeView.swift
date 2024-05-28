//
//  HomeView.swift
//  Workout3
//
//  Created by Warren Hansen on 5/27/24.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    
    // to segue
    @Environment(\.modelContext) private var modelContext
    @Query private var exercise: [Exercise]
    let dataLoader =  DataLoader()
    
    // for this view
    let groups: [String] = ["Group A", "Group B", "Group C", "Group D"]
    
    @Query(filter: #Predicate<Exercise> { exercises in
        exercises.group == "Group A"
    }) var groupA: [Exercise]
    
    @Query(filter: #Predicate<Exercise> { exercises in
        exercises.group == "Group B"
    }) var groupB: [Exercise]
    
    @Query(filter: #Predicate<Exercise> { exercises in
        exercises.group == "Group C"
    }) var groupC: [Exercise]
    
    @Query(filter: #Predicate<Exercise> { exercises in
        exercises.group == "Group D"
    }) var groupD: [Exercise]
    
    var body: some View {
        
        NavigationView {
            List(groups, id: \.self) { group in
                NavigationLink(destination: ExerciseGroup(groupName: group)) {
                    
                    VStack(alignment: .leading) {
                        Text(group).font(.headline)
                        
                        HStack {
                            switch group {
                            case "Group A" :
                                let date = groupA.first?.date ?? Date()
                                Text("\(date.formatted(date: .abbreviated, time: .omitted))")
                                Text(date.formatted(date: .omitted, time: .shortened))
                            case "Group B" :
                                let date = groupB.first?.date ?? Date()
                                Text("\(date.formatted(date: .abbreviated, time: .omitted))")
                                Text(date.formatted(date: .omitted, time: .shortened))
                            case "Group C" :
                                let date = groupC.first?.date ?? Date()
                                Text("\(date.formatted(date: .abbreviated, time: .omitted))")
                                Text(date.formatted(date: .omitted, time: .shortened))
                            case "Group D" :
                                let date = groupD.first?.date ?? Date()
                                Text("\(date.formatted(date: .abbreviated, time: .omitted))")
                                Text(date.formatted(date: .omitted, time: .shortened))
                            default:
                                Text("No Date")
                            }
                        }.font(.caption).foregroundStyle(.secondary)
                    }
                    //MainListRow(workout: workout)
                }
                
            }.navigationTitle("Training Plan")
                
        }
        .onAppear() {
            //deleteExercises()
            loadExercises()
        }
    }
    
    private func deleteExercises() {
        print("delete all")
        do {
            try modelContext.delete(model: Exercise.self)
        } catch {
            print("Failed to clear all Country and City data.")
        }
    }
    
    private func loadExercises() {
        if exercise.isEmpty {
            firstRun()
        }
    }
    
    private func firstRun() {
        print("first run \(Date().formatted())")
        for item in dataLoader.GroupA() {
            modelContext.insert(item)
        }
        
        for item in dataLoader.GroupB() {
            modelContext.insert(item)
        }
        
        for item in dataLoader.GroupC() {
            modelContext.insert(item)
        }
        
        for item in dataLoader.GroupD() {
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
    
    for item in dataLoader.GroupB() {
        container.mainContext.insert(item)
    }
    
    for item in dataLoader.GroupC() {
        container.mainContext.insert(item)
    }
    
    for item in dataLoader.GroupD() {
        container.mainContext.insert(item)
    }
    
    return HomeView()
        .modelContainer(container)
    
}
