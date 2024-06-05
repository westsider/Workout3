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
    
    // neew to implement this fun when exercise completes
    func createWeightTrainingWorkout(start: Date, end: Date, energyBurned: Double, completion: @escaping (Bool, Error?) -> Void) {
        guard let activeEnergyType = HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned) else {
            completion(false, NSError(domain: "HealthKit", code: 1, userInfo: [NSLocalizedDescriptionKey: "Active energy type is unavailable."]))
            return
        }
        
        let energyBurnedQuantity = HKQuantity(unit: HKUnit.kilocalorie(), doubleValue: energyBurned)
        let energyBurnedSample = HKQuantitySample(type: activeEnergyType, quantity: energyBurnedQuantity, start: start, end: end)
        
        let workout = HKWorkout(activityType: .traditionalStrengthTraining,
                                start: start,
                                end: end,
                                workoutEvents: nil,
                                totalEnergyBurned: energyBurnedQuantity,
                                totalDistance: nil,
                                metadata: nil)
        
        healthStore.save(workout) { success, error in
            if success {
                self.healthStore.add([energyBurnedSample], to: workout) { success, error in
                    completion(success, error)
                }
            } else {
                completion(success, error)
            }
        }
    }
    
    /* here is how to implement it!
     let healthStoreManager = HealthStoreManager()
     let startDate = Date() // replace with actual start date
     let endDate = Date() // replace with actual end date
     let energyBurned = 300.0 // replace with actual energy burned in kilocalories

     healthStoreManager.requestAuthorization { success, error in
         if success {
             healthStoreManager.createWeightTrainingWorkout(start: startDate, end: endDate, energyBurned: energyBurned) { success, error in
                 if success {
                     print("Workout saved successfully!")
                 } else {
                     print("Error saving workout: \(String(describing: error?.localizedDescription))")
                 }
             }
         } else {
             print("Authorization failed: \(String(describing: error?.localizedDescription))")
         }
     }

     */

}

