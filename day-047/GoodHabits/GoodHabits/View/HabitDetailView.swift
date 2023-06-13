//
//  HabitDetailView.swift
//  GoodHabits
//
//  Created by Nelson Silva on 12/06/2023.
//

import SwiftUI

struct HabitDetailView: View {
    
    @Environment(\.dismiss) private var dismiss
    @State var habit : Habit
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            HStack {
                Text(habit.name)
                    .font(.largeTitle)
                    .padding()
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(habit.wasDoneWithinPeriod ? .coolGreen : .red)

            VStack {
                
                Text(habit.description)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .padding(.bottom)
                
                HStack {
                    Text("Done ")
                    Text(habit.timesDone, format: .number)
                        .font(.largeTitle)
                        .foregroundColor(habit.timesDone == 0 ? .red : .primary)
                    Text(" times!")
                }
                
                HStack {
                    Button {
                        habit.timesDone += 1
                        habit.lastDoneAt = Date.now
                        dismiss()
                    } label: {
                        Text("Done just now!")
                    }
                    
                    Spacer()
                    
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                    }
                }
                .padding(.vertical)
            }
            .padding()
            
            Spacer()
        }
        .frame(maxHeight: .infinity)
        .navigationTitle("Edit habit")
        
        
    }
}

struct HabitDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let habit = HabitController().habits[0]
        HabitDetailView(habit: habit)
    }
}
