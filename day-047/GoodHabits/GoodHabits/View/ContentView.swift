//
//  ContentView.swift
//  GoodHabits
//
//  Created by nfls on 11/06/2023.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var habitController = HabitController()
    @State private var showAddSheet = false

    var body: some View {
        NavigationView {
            List(habitController.habits.sorted { $0.timesDone > $1.timesDone }) { habit in
                NavigationLink {
                    
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
            .navigationTitle("GoodHabits")
            .toolbar {
                Button {
                    showAddSheet.toggle()
                } label : {
                    Image(systemName: "plus.app")
                        .tint(.primary)
                }
                .sheet(isPresented: $showAddSheet) {
                    AddNewHabitView(habitController: habitController)
                }
            }

        }
    }
    

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            //.preferredColorScheme(.dark)
    }
}
