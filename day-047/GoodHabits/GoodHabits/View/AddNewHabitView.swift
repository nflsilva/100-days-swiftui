//
//  AddNewHabitView.swift
//  GoodHabits
//
//  Created by nfls on 11/06/2023.
//

import SwiftUI

struct AddNewHabitView: View {
    
    @Environment(\.dismiss) private var dismiss
    @StateObject var habitController : HabitController
    @State private var name: String = ""
    @State private var description: String = ""
    @State private var periodicalyHours: UInt = 1
    @State private var showAlert: Bool = false
    
    var body: some View {
        
        VStack {
            Form {
                
                Text("New Habit")
                    .font(.title)
                
                Section {
                    TextField("Name", text: $name)
                    TextField("Description", text: $description)
                    TextField("Periodicaly (hours)", value: $periodicalyHours, format: .number)
                        .keyboardType(.numberPad)
                }

                HStack {
                    Button("Done") {
                        
                        do {
                            try habitController.addHabit(habit: Habit(name: name, description: description, periodicityHours: periodicalyHours))
                        } catch {
                            showAlert = true
                        }
                        
                        if !showAlert {
                            dismiss()
                        }
                        
                    }
                    .foregroundColor(.primary)
                    
                    Spacer()
                    
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundColor(.primary)
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Error"),
                      message: Text("Habit \(name) already exists."),
                      dismissButton: .default(Text("Ok"))
                
                )
            }
        }

    }
}

struct AddNewHabitView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewHabitView(habitController: HabitController())
    }
}
