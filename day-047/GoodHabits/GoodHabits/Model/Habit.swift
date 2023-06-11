//
//  Habit.swift
//  GoodHabits
//
//  Created by nfls on 11/06/2023.
//

import Foundation

struct Habit: Codable, Identifiable {
    let id: UUID = UUID()
    let name: String
    let description: String
    var timesDone: UInt = 0
    let periodicityHours: UInt
    var lastDoneAt: Date?
    
    var wasDoneWithinPeriod: Bool {
        if lastDoneAt == nil {
            return true
        }
        
        let calendar = NSCalendar.current
        let deadline = calendar.date(byAdding: .hour, value: Int(periodicityHours), to: lastDoneAt!) ?? Date.now
        return Date.now <= deadline
    }
    
    var displayDate: String? {
        lastDoneAt?.formatted(date: .abbreviated, time: .omitted)
    }
    
}
