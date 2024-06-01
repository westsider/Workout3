//
//  Workout.swift
//  Workout3
//
//  Created by Warren Hansen on 6/1/24.
//

import Foundation

struct PrancerciseWorkoutInterval {
    var start: Date
    var end: Date
    
    init(start: Date, end: Date) {
        self.start = start
        self.end = end
    }
    
    var duration: TimeInterval {
        return end.timeIntervalSince(start)
    }
    
    var totalEnergyBurned: Double {
        let prancerciseCaloriesPerHour: Double = 450
        let hours: Double = duration/3600
        let totalCalories = prancerciseCaloriesPerHour * hours
        return totalCalories
    }
}

struct PrancerciseWorkout {
    var start: Date
    var end: Date
    var intervals: [PrancerciseWorkoutInterval]
    
    init(with intervals: [PrancerciseWorkoutInterval]) {
        self.start = intervals.first!.start
        self.end = intervals.last!.end
        self.intervals = intervals
    }
    
    var totalEnergyBurned: Double {
        return intervals.reduce(0) { (result, interval) in
            result + interval.totalEnergyBurned
        }
    }
    
    var duration: TimeInterval {
        return intervals.reduce(0) { (result, interval) in
            result + interval.duration
        }
    }
}

enum WorkoutSessionState {
  case notStarted
  case active
  case finished
}

class WorkoutSession {
  private (set) var startDate: Date!
  private (set) var endDate: Date!
  
  var intervals: [PrancerciseWorkoutInterval] = []
  var state: WorkoutSessionState = .notStarted
  
  func start() {
    startDate = Date()
    state = .active
  }
  
  func end() {
    endDate = Date()
    addNewInterval()
    state = .finished
  }
  
  func clear() {
    startDate = nil
    endDate = nil
    state = .notStarted
    intervals.removeAll()
  }
  
  private func addNewInterval() {
    let interval = PrancerciseWorkoutInterval(start: startDate,
                                              end: endDate)
    intervals.append(interval)
  }
  
  var completeWorkout: PrancerciseWorkout? {
    guard state == .finished, intervals.count > 0 else {
      return nil
    }
    
    return PrancerciseWorkout(with: intervals)
  }
}
