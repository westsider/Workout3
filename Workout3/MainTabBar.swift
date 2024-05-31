//
//  MainTabBar.swift
//  Workout3
//
//  Created by Warren Hansen on 5/30/24.
//

import SwiftUI
import SwiftData

struct MainTabBar: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query private var exercise: [Exercise]
    let dataLoader =  DataLoader()
    
    //@EnvironmentObject var manager: HealthManager
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "list.dash")
                }
                //.environmentObject(manager)
            Login()
                .tabItem {
                    Label("Login", systemImage: "square.and.pencil")
                }
            History()
                .tabItem {
                    Label("History", systemImage: "square.and.pencil")
                }
        }.onAppear() {
            loadExercises()
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
    
    return MainTabBar()
        .modelContainer(container)
    }
