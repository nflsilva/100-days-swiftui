//
//  Habit.swift
//  GoodHabits
//
//  Created by nfls on 11/06/2023.
//

import Foundation

class Habit: Codable, Identifiable, ObservableObject {
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case description = "description"
        case timesDone = "timesDone"
        case periodicityHours = "periodicityHours"
        case lastDoneAt = "lastDoneAt"
    }
    
    let id: UUID = UUID()
    let name: String
    let description: String
    @Published var timesDone: UInt = 0
    let periodicityHours: UInt
    var lastDoneAt: Date?

    init(name: String, description: String, periodicityHours: UInt) {
        self.name = name
        self.description = description
        self.periodicityHours = periodicityHours
        self.lastDoneAt = nil
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
    }
    
    func decode(from decoder: Decoder) throws {
        var container = decoder.container(keyedBy: CodingKeys.self)
    }
 
    var wasDoneWithinPeriod: Bool {
        if lastDoneAt == nil {
            return false
        }
        
        let calendar = NSCalendar.current
        let deadline = calendar.date(byAdding: .hour, value: Int(periodicityHours), to: lastDoneAt!) ?? Date.now
        return Date.now <= deadline
    }
    
    var displayDate: String? {
        lastDoneAt?.formatted(date: .abbreviated, time: .omitted)
    }
    
}
