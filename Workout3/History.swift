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
        if historical.isEmpty {
            Text("No History!")
        }
        List {
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
                    }.font(.footnote).foregroundColor(.secondary)
                }
            }.onDelete(perform: { indexSet in
                deleteWorkout(at: indexSet)
            })
        }
    }
    
    func deleteWorkout(at offsets: IndexSet) {
        for offset in offsets {
            let workout = historical[offset]
            modelContext.delete(workout)
        }
    }
    
    func sortDate() {
//        let convertedObjects = testObjects
//            .map { return ($0, dateFormatter.date(from: $0.dateStr)!) }
//            .sorted { $0.1 > $1.1 }
//            .map(\.0)
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
