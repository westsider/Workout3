//
//  ExerciseReps.swift
//  Workout3
//
//  Created by Warren Hansen on 5/26/24.
//

import SwiftUI

struct ExerciseReps: View {
    var exercise: Exercise
    @State var isOn: [Bool] = [false, false, false, false]
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
                    Toggle("", isOn: $isOn[num - 1])
                                .toggleStyle(CheckToggleStyle())
                }
            }
        }
    }
}

#Preview {
    ExerciseReps(exercise: Exercise(group: "Group A", name: "Bench", numReps: 8, numSets: 4, weight: 135, completed: false, date: Date()))
}
