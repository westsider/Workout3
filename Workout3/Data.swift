//
//  Data.swift
//  Workout3
//
//  Created by Warren Hansen on 5/26/24.
//

import SwiftUI
import SwiftData

@Model
final class Exercise {
    var id = UUID()
    var group: String
    var name: String
    var numReps: Int
    var numSets: Int
    var weight: Int
    var completed: Bool
    var date: Date
    
    init(group: String, name: String, numReps: Int, numSets: Int, weight: Int, completed: Bool, date: Date) {
        self.group = group
        self.name = name
        self.numReps = numReps
        self.numSets = numSets
        self.weight = weight
        self.completed = completed
        self.date = date
    }
}

class DataLoader {
    
    func GroupA() -> [Exercise] {
        let exercise1 = Exercise(group: "Group A", name: "BB Squat", numReps: 8, numSets: 4, weight: 160, completed: false, date: Date())
        let exercise2 = Exercise(group: "Group A", name: "Incline DB Press", numReps: 8, numSets: 4, weight: 45, completed: false, date: Date())
        let exercise3 = Exercise(group: "Group A", name: "DB Seal Row", numReps: 8, numSets: 4, weight: 40, completed: false, date: Date())
        let exercise4 = Exercise(group: "Group A", name: "One Arm Delta Fly's", numReps: 8, numSets: 3, weight: 20, completed: false, date: Date())
        let exercise5 = Exercise(group: "Group A", name: "Leg Raises", numReps: 8, numSets: 3, weight: 0, completed: false, date: Date())
        var exercises: [Exercise] = []
        exercises.append(exercise1)
        exercises.append(exercise2)
        exercises.append(exercise3)
        exercises.append(exercise4)
        exercises.append(exercise5)
        return exercises
    }
    
    func GroupB() -> [Exercise] {
        let exercise1 = Exercise(group: "Group B", name: "Bulgarian Split Squat", numReps: 8, numSets: 4, weight: 20, completed: false, date: Date())
        let exercise2 = Exercise(group: "Group B", name: "Military Press", numReps: 8, numSets: 4, weight: 60, completed: false, date: Date())
        let exercise3 = Exercise(group: "Group B", name: "Lat Pulldown", numReps: 8, numSets: 4, weight: 120, completed: false, date: Date())
        let exercise4 = Exercise(group: "Group B", name: "Rear Delta Fly", numReps: 8, numSets: 3, weight: 20, completed: false, date: Date())
        let exercise5 = Exercise(group: "Group B", name: "Leg Raises", numReps: 8, numSets: 3, weight: 0, completed: false, date: Date())
        var exercises: [Exercise] = []
        exercises.append(exercise1)
        exercises.append(exercise2)
        exercises.append(exercise3)
        exercises.append(exercise4)
        exercises.append(exercise5)
        return exercises
    }
    
    func GroupC() -> [Exercise] {
        let exercise1 = Exercise(group: "Group C", name: "Leg Press", numReps: 8, numSets: 4, weight: 160, completed: false, date: Date())
        let exercise2 = Exercise(group: "Group C", name: "Incline Chest Machine", numReps: 8, numSets: 4, weight: 70, completed: false, date: Date())
        let exercise3 = Exercise(group: "Group C", name: "Back Row Machine", numReps: 8, numSets: 4, weight: 140, completed: false, date: Date())
        let exercise4 = Exercise(group: "Group C", name: "Sholder Press Machine", numReps: 8, numSets: 4, weight: 60, completed: false, date: Date())
        let exercise5 = Exercise(group: "Group C", name: "Leg Raises", numReps: 8, numSets: 3, weight: 0, completed: false, date: Date())
        var exercises: [Exercise] = []
        exercises.append(exercise1)
        exercises.append(exercise2)
        exercises.append(exercise3)
        exercises.append(exercise4)
        exercises.append(exercise5)
        return exercises
    }
    
    func GroupD() -> [Exercise] {
        let exercise1 = Exercise(group: "Group D", name: "Bench D", numReps: 8, numSets: 4, weight: 135, completed: false, date: Date())
        let exercise2 = Exercise(group: "Group D", name: "Curls D", numReps: 8, numSets: 3, weight: 50, completed: false, date: Date())
        let exercise3 = Exercise(group: "Group D", name: "Fly's", numReps: 8, numSets: 4, weight: 40, completed: false, date: Date())
        let exercise4 = Exercise(group: "Group D", name: "Chin Raises", numReps: 8, numSets: 4, weight: 60, completed: false, date: Date())
        let exercise5 = Exercise(group: "Group D", name: "Leg Raises", numReps: 8, numSets: 3, weight: 0, completed: false, date: Date())
        var exercises: [Exercise] = []
        exercises.append(exercise1)
        exercises.append(exercise2)
        exercises.append(exercise3)
        exercises.append(exercise4)
        exercises.append(exercise5)
        return exercises
    }
}

struct WorkOutNames: Identifiable {
    
    let id = UUID()
    let name: String
    let description: String
    let image: Image
    let progress: CGFloat
    let group: String
    let date: Date
}
