//
//  ExerciseReps.swift
//  Workout3
//
//  Created by Warren Hansen on 5/26/24.
//

import SwiftUI
import SwiftData

struct ExerciseReps: View {
    
    var id: UUID
    @Environment(\.modelContext) private var modelContext
    @State var isOn: [Bool] = [false, false, false, false]
    @State private var weight = 45
    @Query private var exercise: [Exercise]
    
    // get this exercise bu UUID
    init(id: UUID) {
        self.id = id
        _exercise = Query(filter: #Predicate<Exercise> { exercises in
            exercises.id == id
        })
    }
    
    var body: some View {
        VStack {
            ForEach(1...(exercise.first?.numSets ?? 3), id: \.self) { num in
                HStack {
                    Text("\(weight) lbs")
                    Spacer()
                    Stepper("", onIncrement: {
                        weight += 5
                    }, onDecrement: {
                        weight -= 5
                    })
                    Spacer()
                    Text("\(exercise.first?.numReps ?? 8) Reps")
                    Spacer()
                    Toggle("", isOn: $isOn[num - 1])
                        .toggleStyle(CheckToggleStyle())
                        
                }
            }.onAppear() {
                weight = exercise.first?.weight ?? 45
            }.onDisappear() {
                exercise.first?.weight = weight
            }.onChange(of: isOn) { newValue in
                // check for completed reps
                let numSets = exercise.first?.numSets ?? 3
                let numberOfTrue = isOn.filter{$0}.count
                print("\(String(describing: exercise.first?.name ?? "NA")) completed \(numberOfTrue) of \(numSets)")
                if numSets == numberOfTrue {
                    print("\ncompleted \(exercise.first?.name ?? "NA") on the ExerciseReps struct\n")
                    exercise.first?.completed = true
                }
            }
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
    
    return ExerciseReps(id: UUID())
        .modelContainer(container)
}
