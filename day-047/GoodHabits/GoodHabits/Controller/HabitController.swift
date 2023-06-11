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
        case general
    }
    
    @Published var habits = [Habit]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(habits) {
                UserDefaults.standard.set(encoded, forKey: "habits")
            }
        }
    }
    
    init() {
        if let jsonData = UserDefaults.standard.data(forKey: "habits"),
           let loadedHabits = try? JSONDecoder().decode([Habit].self, from: jsonData) {
            habits = loadedHabits
            return
        }
        habits = []
    }
    
    func addHabit(habit: Habit) throws {
        if habits.contains(where: { h in  h.name == habit.name }) {
            throw HabitError.duplicatedName
        }
        habits.append(habit)
    }
    
}
