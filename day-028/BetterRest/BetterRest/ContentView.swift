//
//  ContentView.swift
//  BetterRest
//
//  Created by nfls on 17/05/2023.
//

import CoreML
import SwiftUI

struct ContentView: View {
    
    @State private var wakeupTime = defaultWakeTime
    @State private var desiredHoursOfSleep = 4.0
    @State private var dailyCofeeCups = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    @State private var sleepTime: Date? = nil
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    private func calculatedBedTime() {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeupTime)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute),
                                                  estimatedSleep: desiredHoursOfSleep,
                                                  coffee: Double(dailyCofeeCups))
            
            sleepTime = wakeupTime - prediction.actualSleep
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime."
            showingAlert = true
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                
                Section {
                    Text("When do you want to wake up?")
                        .font(.headline)
                    DatePicker("Desired amout of sleep",
                               selection: $wakeupTime,
                               displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .onChange(of: wakeupTime) { _ in calculatedBedTime() }
                }

                Section {
                    Text("Desired amount of sleep")
                        .font(.headline)
                    Stepper("\(desiredHoursOfSleep.formatted()) hours",
                            value: $desiredHoursOfSleep,
                            in: 4...12, step: 0.25)
                        .onChange(of: desiredHoursOfSleep) { _ in calculatedBedTime() }
                }
                
                Section {
                    Text("Daily coffee intake")
                        .font(.headline)
                    Picker(dailyCofeeCups == 1 ? "1 cup" : "\(dailyCofeeCups) cups",
                           selection: $dailyCofeeCups) {
                        ForEach(1..<21) {
                            Text($0 == 1 ? "1 cup" : "\($0) cups")
                        }
                    }
                }
                
                if let sleepTime = sleepTime {
                    Section {
                        Text("Calculated bedtime")
                            .font(.headline)
                        Text("Your ideal bedtime is \(sleepTime.formatted(date: .omitted, time: .shortened))")
                    }
                }

            }
            
            .navigationTitle("BetterRest")
            .alert(alertTitle, isPresented: $showingAlert) {
                Button("OK") { }
            } message: {
                Text(alertMessage)
            }
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
