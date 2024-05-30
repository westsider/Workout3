//
//  HomeListRow.swift
//  Workout3
//
//  Created by Warren Hansen on 5/28/24.
//

import SwiftUI

struct HomeListRow : View {

    let workout: WorkOutNames
    
    var body: some View {
        HStack {
            workout.image
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 80)
                .cornerRadius(7) // Inner corner radius
                    .padding(5) // Width of the border
                    .background(Color.primary) // Color of the border
                    .cornerRadius(10)
            VStack(alignment: .leading) {
                Text(workout.name)
                    .foregroundColor(.primary)
                    .font(.headline)
                Text(workout.description)
                    .foregroundColor(.secondary)
                    .font(.subheadline)
                ProgressView(value: workout.progress)
                HStack {
                    Text("\(workout.date.formatted(date: .abbreviated, time: .omitted))")
                    Text(workout.date.formatted(date: .omitted, time: .shortened))
                    if workout.group != "stretch" {
                        Spacer()
                        Text(workout.timeElapsed, format: .timerCountdown)
                    }
                }.font(.caption).foregroundStyle(.secondary)
            }
        }
    }
}

#Preview {
    HomeListRow(workout: WorkOutNames(name: "Trident",
                                      description: "Only Easy Day Was Yesterday", image: Image("behind"), progress: 0.8,  group: "Group A", date: Date(), timeElapsed: 60))
}
