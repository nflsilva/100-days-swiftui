//
//  HabitController.swift
//  GoodHabits
//
//  Created by nfls on 11/06/2023.
//

import Foundation

class HabitController: ObservableObject {
    
    enum HabitError: Error {
        case duplicatedName
        case invalidData
    }
    
    @Published var habits = [Habit]()
    
    init() {
        if let jsonData = UserDefaults.standard.data(forKey: "habits"),
           let loadedHabits = try? JSONDecoder().decode([Habit].self, from: jsonData) {
            habits = loadedHabits
            return
        }
        habits = []
    }
    
    func saveHabits() {
        if let encoded = try? JSONEncoder().encode(habits) {
            UserDefaults.standard.set(encoded, forKey: "habits")
        }
    }
    
    func addHabit(habit: Habit) throws {
        if habits.contains(where: { h in  h.name == habit.name }) {
            throw HabitError.duplicatedName
        }
        
        if habit.name == "" || habit.description == "" {
            throw HabitError.invalidData
        }
        
        habits.append(habit)
        saveHabits()
    }
    
}
