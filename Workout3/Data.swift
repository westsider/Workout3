//
//  Data.swift
//  Workout3
//
//  Created by Warren Hansen on 5/26/24.
//

import Foundation
import SwiftData

@Model
final class Exercise {
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
        let exercise1 = Exercise(group: "Group A", name: "Bench", numReps: 8, numSets: 4, weight: 135, completed: false, date: Date())
        
        let exercise2 = Exercise(group: "Group A", name: "Curls", numReps: 8, numSets: 3, weight: 50, completed: false, date: Date())
        
        let exercise3 = Exercise(group: "Group A", name: "Fly's", numReps: 8, numSets: 4, weight: 40, completed: false, date: Date())
        
        let exercise4 = Exercise(group: "Group A", name: "Leg Lifts", numReps: 8, numSets: 3, weight: 0, completed: false, date: Date())
        var exercises: [Exercise] = []
        exercises.append(exercise1)
        exercises.append(exercise2)
        exercises.append(exercise3)
        exercises.append(exercise4)
        return exercises
    }
    
    func GroupB() -> [Exercise] {
        let exercise1 = Exercise(group: "Group B", name: "Bench B", numReps: 8, numSets: 4, weight: 135, completed: false, date: Date())
        
        let exercise2 = Exercise(group: "Group B", name: "Curls B", numReps: 8, numSets: 3, weight: 50, completed: false, date: Date())
        
        let exercise3 = Exercise(group: "Group B", name: "Fly's", numReps: 8, numSets: 4, weight: 40, completed: false, date: Date())
        
        let exercise4 = Exercise(group: "Group B", name: "Leg Lifts B", numReps: 8, numSets: 3, weight: 0, completed: false, date: Date())
        var exercises: [Exercise] = []
        exercises.append(exercise1)
        exercises.append(exercise2)
        exercises.append(exercise3)
        exercises.append(exercise4)
        return exercises
    }
}
