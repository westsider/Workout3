//
//  HomeView.swift
//  Workout3
//
//  Created by Warren Hansen on 5/25/24.
//
//  X make a list of Bench, curls, fly's, lig lift,
//  X items incluse num reps, weight and completed
//  X ui has each item and num reps completed
//  X toggle set completed
//  X create aonther workout goup
//  X step weight
//  X main screen
//  X nav to exercise screen
//  X when all completed return to main and show last workout
//  X use correct workouts
//  X show last workout
//  X improve main UI
//  X add stretching
//  X start a workout timer for each workout duration
//  X tab bar: home, login, history
//  X login screen
//  X persist all workouts, dates, duration, make a list

//  send data to apple workout
//  remove group array and just use [Exercise] sorted by date decending so next workout is on top

// access workouts https://www.youtube.com/watch?v=RN_ZgV0Lk-Y



import SwiftUI
import SwiftData

struct HomeView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query private var exercise: [Exercise]
    let dataLoader =  DataLoader()
    
    let groups: [String] = ["Group A", "Group B", "Group C", "Group D", "stretch", "Calisthenics"]
    
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
    
    @Query(filter: #Predicate<Exercise> { exercises in
        exercises.group == "stretch"
    }) var stretch: [Exercise]
    
    @Query(filter: #Predicate<Exercise> { exercises in
        exercises.group == "Calisthenics"
    }) var calisthenics: [Exercise]

    var body: some View {
        
        NavigationStack {
            List(groups, id: \.self) { group in
                NavigationLink(destination: ExerciseGroup(groupName: group)) {
                    HStack {
                        switch group {
                        case "Group A" :
                            HomeListRow(workout: WorkOutNames(name: "Falcon", description: "Don't Get Snatched", image: Image("squat"), progress: 0.25,  group: "Group A", date: groupA.first?.date ?? Date(), timeElapsed: groupA.first?.timeElapsed ?? 0))
                            
                        case "Group B" :
                            HomeListRow(workout: WorkOutNames(name: "Deep Horizon", description: "We Take You To Crush Depth", image: Image("behind"), progress: 0.3,  group: "Group B", date: groupB.first?.date ?? Date(), timeElapsed: groupB.first?.timeElapsed ?? 0))
                        case "Group C" :
                            HomeListRow(workout: WorkOutNames(name: "Challenger", description: "Failure Is Not An Option", image: Image("grip"), progress: 0.8,  group: "Group C", date: groupC.first?.date ?? Date(), timeElapsed: groupC.first?.timeElapsed ?? 0))
                        case "Group D" :
                            HomeListRow(workout: WorkOutNames(name: "Trident",              description: "Only Easy Day Was Yesterday", image: Image("press"), progress: 0.5,  group: "Group D", date: groupD.first?.date ?? Date(), timeElapsed: groupD.first?.timeElapsed ?? 0))
                        case "stretch" :
                            HomeListRow(workout: WorkOutNames(name: "Stretch", description: "Just Let It Go", image: Image("stretch"), progress: 0.5,  group: "stretch", date: Date(), timeElapsed: stretch.first?.timeElapsed ?? 0))
                        case "Calisthenics" :
                            HomeListRow(workout: WorkOutNames(name: "Calisthenics", description: "Just Get It Done", image: Image("stretch"), progress: 0.5,  group: "stretch", date: Date(), timeElapsed: stretch.first?.timeElapsed ?? 0))
                        default:
                            Text("No Date")
                        }
                    }
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
        
        for item in dataLoader.stretch() {
            modelContext.insert(item)
        }
        
        for item in dataLoader.calisthenics() {
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
    
    for item in dataLoader.stretch() {
        container.mainContext.insert(item)
    }
    
    for item in dataLoader.calisthenics() {
        container.mainContext.insert(item)
    }
    return HomeView()
        .modelContainer(container)
    
}

let activityDefault = Activity(id: 0, title: "Daily Steps", subtitle: "Goal 10,000", image: "figure.walk", amount: "200")
