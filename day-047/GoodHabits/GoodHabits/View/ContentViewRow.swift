//
//  ContentViewRow.swift
//  GoodHabits
//
//  Created by nfls on 13/06/2023.
//

import SwiftUI

struct ContentViewRow: View {
    
    @StateObject var habit: Habit
    let habitController: HabitController
    
    var body: some View {
        NavigationLink {
            HabitDetailView(habit: habit, habitController: habitController)
        } label: {
            VStack(alignment: .leading) {
                
                HStack {
                    Text(habit.name)
                        .font(.headline)
                    if habit.wasDoneWithinPeriod {
                        Image(systemName: "checkmark.seal.fill")
                            .foregroundColor(.green)
                    }
                }

                Text(habit.timesDone, format: .number)
                    .font(.subheadline.smallCaps())
                
                Text("Done at: \(habit.displayDate ?? "never")")
                    .font(.subheadline)
            }
        }
        .padding(.vertical)
    }
}

struct ContentViewRow_Previews: PreviewProvider {
    static var habitController = HabitController()
    
    static var previews: some View {
        ContentViewRow(habit: habitController.habits[0], habitController: habitController)
    }
}
