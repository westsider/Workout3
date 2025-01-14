//
//  History.swift
//  Workout3
//
//  Created by Warren Hansen on 5/30/24.
//

import SwiftUI
import SwiftData

struct History: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Historical.date, order: .reverse) var historical: [Historical]
    
    var body: some View {
        List {
            if historical.isEmpty {
                Text("No History!")
            } else {
                ForEach(historical, id: \.self) { workout in
                    VStack(alignment: .leading) {
                        HStack {
                            Text(workout.name)
                            Spacer()
                            Text(workout.timeElapsed, format: .timerCountdown)
                            Text("minutes")
                        }
                        
                        HStack {
                            Text("\(workout.date.formatted(date: .abbreviated, time: .omitted))")
                            Text(" @ ")
                            Text(workout.date.formatted(date: .omitted, time: .shortened))
                        }
                        .font(.footnote)
                        .foregroundColor(.secondary)
                    }
                }
                .onDelete(perform: deleteWorkout)
            }
        }
    }

    
    func deleteWorkout(at offsets: IndexSet) {
        for offset in offsets {
            let workout = historical[offset]
            modelContext.delete(workout)
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Historical.self, configurations: config)
    let item = Historical(name: "Group A", date: Date(), timeElapsed: 500)
    container.mainContext.insert(item)
    return History()
        .modelContainer(container)
}


/*
 
 if workout.group != "stretch" {
 Spacer()
 Text(workout.timeElapsed, format: .timerCountdown)
 */
