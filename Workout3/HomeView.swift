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
    let groups: [String] = ["Group A", "Group B"]
    
    var body: some View {
  
        NavigationView {
            List(groups, id: \.self) { group in
                    NavigationLink(destination: ExerciseGroup(groupName: group)) {
                        Text(group)
                        //MainListRow(workout: workout)
                    }
            }.navigationTitle("Training Plan")
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
    return HomeView()
        .modelContainer(container)
    
     }
