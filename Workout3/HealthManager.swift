//
//  HealthManager.swift
//  Workout3
//
//  Created by Warren Hansen on 5/31/24.
//

import Foundation
import HealthKit


/*
    June 1 2024, made a beginning to helth store by retrieving health data.
    the path to send workouts seems very comples so I am pausing here.
 */

class HealthManager: ObservableObject {
    
    let healthStore = HKHealthStore()
    @Published var todaysSteps: String = "No Steps"
    @Published var todaysCalories: String = "No Calories"
    

    
    init() {
//        let steps = HKQuantityType(.stepCount)
//        let calories = HKQuantityType(.activeEnergyBurned)
//        let healthTypes: Set = [steps, calories]
        
        let typesToShare: Set = [
                    HKObjectType.workoutType(),
                    HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!
                ]
                
                let typesToRead: Set = [
                    HKObjectType.workoutType(),
                    HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)!,
                    HKQuantityType(.stepCount),
                    HKQuantityType(.activeEnergyBurned)
                ]
        
        Task {
            do {
                try await healthStore.requestAuthorization(toShare: typesToShare,read: typesToRead)
                fetchTodaysSteps()
                fetchTodaysCalories()
            } catch {
                print("error fetching health data")
            }
        }
    }
    
    func fetchTodaysSteps()  {
        let steps = HKQuantityType(.stepCount)
        let predicate = HKQuery.predicateForSamples(withStart: .startOfDay, end: Date())
        let query = HKStatisticsQuery(quantityType: steps, quantitySamplePredicate: predicate) { _, result, error in
            guard let result = result, let quantity = result.sumQuantity(), error == nil else {
                print("error fetching todays step data")
                return
            }
            let stepCount = quantity.doubleValue(for: .count())
            let activity = stepCount.formattedString()
            DispatchQueue.main.async {
                self.todaysSteps  = activity
            }
            
            print("Todays steps: \(stepCount.formattedString())")
        }
        healthStore.execute(query)
    }
    
    func fetchTodaysCalories()  {
        let calories = HKQuantityType(.activeEnergyBurned)
        let predicate = HKQuery.predicateForSamples(withStart: .startOfDay, end: Date())
        let query = HKStatisticsQuery(quantityType: calories, quantitySamplePredicate: predicate) { _, result, error in
            guard let result = result, let quantity = result.sumQuantity(), error == nil else {
                print("error fetching todays calorie data")
                return
            }
            let calorieBurned = quantity.doubleValue(for: .kilocalorie())
            let activity = calorieBurned.formattedString()
            DispatchQueue.main.async {
                self.todaysCalories  = activity
            }
            
            print("Todays calories: \(calorieBurned.formattedString())")
        }
        healthStore.execute(query)
    }
}

