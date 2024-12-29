//
//  ContentView.swift
//  Workout3
//
//  Created by Warren Hansen on 5/25/24.
//


import SwiftUI
import SwiftData

struct ExerciseGroup: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext
    @Query private var exercise: [Exercise]
    @Query private var historical: [Historical]
    let dataLoader =  DataLoader()
    let groupName: String
    @State var completed = 0
    
    // timer
    @State var startDate = Date.now
    @State var timeElapsed: Int = 60
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @Query(filter: #Predicate<Exercise> { exercises in
        exercises.group == "Group A"
    }) var exercises: [Exercise]
    
    init(groupName: String) {
        self.groupName = groupName
        _exercises = Query(filter: #Predicate<Exercise> { exercisesS in
            exercisesS.group == groupName
        })
    }
    
    // steps and calories
    @StateObject var manager = HealthManager()
    @State var todaysSteps: Double = 0.0
    
    func calculateCaloriesBurned(weightInKg: Double, durationInMinutes: Double, metValue: Double) -> Double {
        let durationInHours = durationInMinutes / 60.0
        let caloriesBurned = metValue * weightInKg * durationInHours
        return caloriesBurned
    }
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            HStack {
                Text("\(manager.todaysSteps) Steps")
                Spacer()
                Text("\(manager.todaysCalories) calories")
            }.font(.footnote).foregroundColor(.secondary)
            
            HStack {
                Text(groupName).font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                Spacer()
                if groupName != "stretch" {
                    Text(timeElapsed, format: .timerCountdown)
                        .foregroundStyle(.secondary)
                        .onReceive(timer) { firedDate in
                            //print("timer fired")
                            timeElapsed = Int(firedDate.timeIntervalSince(startDate)) + 240  // 4 minute stretch
                        }
                    
                }
            }
            List(exercises)  { this in
                Section(header: Text(this.name)) {
                    ExerciseReps(id: this.id)
                }.headerProminence(.increased)
                    .foregroundStyle(this.completed ? .blue : .primary)
                    .onChange(of: this.completed) { newValue in
                        
                        // save workout unless its a stretch
                        if exercisesCompleted() && groupName != "stretch"  {
                            print("Group List Page:  \(this.group) Workout Complete on \(this.date)")
                            getCaloriesAndSteps()
                            saveWorkout(name: this.group, date: this.date, elapsed: timeElapsed)
                            updateHealthKit()
                            //debugExerciceCompleted()
                            resetExercise()
                            dismiss()
                        }
                        // after 45 mins, mark exercise as complete
                        if timeElapsed > 2700 { 
                            getCaloriesAndSteps()
                            saveWorkout(name: this.group, date: this.date, elapsed: timeElapsed)
                            updateHealthKit()
                            //debugExerciceCompleted()
                            resetExercise()
                        }
                    }
            }
            
        }.onAppear() {
            resetExercise()
        }
        .padding()
    }
    
//    func completeExercise(group: String, date: Date) {
//        getCaloriesAndSteps()
//        saveWorkout(name: group, date: date, elapsed: timeElapsed)
//        updateHealthKit()
//        //debugExerciceCompleted()
//        resetExercise()
//        dismiss()
//    }
    
    func updateHealthKit() {
        // Example usage:
        let weightInKg = 97.5224 // 215 lbs
        let durationInMinutes = timeElapsed / 60 // Total workout duration in minutes from seconds divided by 60
        let metValue = 4.5 // MET value for moderate weight training
        
        let caloriesBurned = calculateCaloriesBurned(weightInKg: weightInKg, durationInMinutes: Double(durationInMinutes), metValue: metValue)
        print("Calories burned: \(caloriesBurned)")
        
        let endDate = Date()
        let startDate = startDate
        // Adding 4 minutes to the current date to include stretch
        let calendar = Calendar.current
        guard let dateWithStretch = calendar.date(byAdding: .minute, value: 4, to: endDate)  else {
            print("There was an error adding 4 minutes to the current date.")
            return
        }

        manager.createWeightTrainingWorkout(start: startDate, end: dateWithStretch, energyBurned: caloriesBurned) { success, error in
            if success {
                print("Workout saved successfully! \(durationInMinutes) minutes \(caloriesBurned) calories")
            } else {
                print("Error saving workout: \(String(describing: error?.localizedDescription))")
            }
        }
    }
    func getCaloriesAndSteps() {
        print("calculating steps and calories: TODO")
        let priorSteps = manager.todaysSteps
        let priorCalories = manager.todaysCalories
        
        // get new totals
        manager.fetchTodaysSteps()
        manager.fetchTodaysCalories()
        let newSteps = manager.todaysSteps
        let newCalories = manager.todaysCalories
    }
    
    func saveWorkout(name: String, date: Date, elapsed: Int) {
        let new = Historical(name: name, date: date, timeElapsed: elapsed)
        modelContext.insert(new)
    }
    
    func resetExercise() {
        for each in exercises {
            each.completed = false
            each.date = Date()
            each.timeElapsed = timeElapsed
        }
    }
    func debugExerciceCompleted() {
        for each in exercises {
            print("ExerciseGroup debug: \(each.name) completed: \(each.completed) on \(each.date) elapsed \(each.timeElapsed)")
        }
    }
    
    private func exercisesCompleted() -> Bool {
        var completedExercises: [Bool] {
            return exercises.map{ $0.completed }
        }
        
        let arrayCount = completedExercises.count
        let numberOfTrue = completedExercises.filter{$0}.count
        //print("array: \(completedExercises) :: true count \(numberOfTrue) arrayCount: \(arrayCount)")
        
        if arrayCount == numberOfTrue {
            return true
        } else {
            return false
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
    
    for item in dataLoader.stretch() {
        container.mainContext.insert(item)
    }
    
    for item in dataLoader.calisthenics() {
        container.mainContext.insert(item)
    }
    return ExerciseGroup(groupName: "Calisthenics")
        .modelContainer(container)
}

