//
//  Habit.swift
//  GoodHabits
//
//  Created by nfls on 11/06/2023.
//

import Foundation

class Habit: Codable, Identifiable, ObservableObject {
    
    enum CodingKeys: String, CodingKey {
        case name
        case description
        case timesDone
        case periodicityHours
        case lastDoneAt
    }

    let id: UUID = UUID()
    let name: String
    let description: String
    @Published var timesDone: UInt = 0
    let periodicityHours: UInt
    var lastDoneAt: Date?

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        description = try values.decode(String.self, forKey: .description)
        timesDone = try values.decode(UInt.self, forKey: .timesDone)
        periodicityHours = try values.decode(UInt.self, forKey: .periodicityHours)
        lastDoneAt = try values.decode(Date?.self, forKey: .lastDoneAt)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(description, forKey: .description)
        try container.encode(timesDone, forKey: .timesDone)
        try container.encode(periodicityHours, forKey: .periodicityHours)
        try container.encode(lastDoneAt, forKey: .lastDoneAt)
    }
    
    init(name: String, description: String, periodicityHours: UInt) {
        self.name = name
        self.description = description
        self.periodicityHours = periodicityHours
        self.lastDoneAt = nil
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
        lastDoneAt?.formatted(date: .abbreviated, time: .shortened)
    }
    
}
