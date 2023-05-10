//
//  ContentView.swift
//  iUnits
//
//  Created by Nelson Silva on 10/05/2023.
//

import SwiftUI

struct ContentView: View {
    
    private let units = ["Seconds", "Minutes", "Hours", "Days"]
    private let unitJumps = [60, 60, 24]
    
    @State var valueToConvert = 0.0
    @State var selectedConversionFromUnit = "Seconds"
    @State var selectedConversionToUnit = "Seconds"
    @FocusState private var mealPriceIsFocus: Bool
    
    private func unitToLevel(unit: String) -> Int? {
        return units.firstIndex(of: unit)
    }
    
    private var convertedValue: Double {
        
        guard
            var fromLevel = unitToLevel(unit: selectedConversionFromUnit),
            var toLevel = unitToLevel(unit: selectedConversionToUnit) else {
            return valueToConvert
        }
        
        var finalValue = valueToConvert
        if fromLevel > toLevel {
            for i in toLevel ..< fromLevel {
                finalValue *= Double(unitJumps[i])
            }
        }
        else if fromLevel < toLevel {
            for i in fromLevel ..< toLevel {
                finalValue /= Double(unitJumps[i])
            }
        }
        
        return finalValue
    }
    
    var body: some View {
        NavigationView {
            Form {
                
                Section {
                    TextField("Value to convert", value: $valueToConvert, format: .number)
                } header: {
                    Text("Converting Time Units")
                }
                
                Section {
                    Picker("Conversions", selection: $selectedConversionFromUnit) {
                        ForEach(units, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    .keyboardType(.numberPad)
                } header: {
                    Text("From")
                }
                
                Section {
                    Picker("Conversions",selection: $selectedConversionToUnit) {
                        ForEach(units, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    .keyboardType(.numberPad)
                } header: {
                    Text("To")
                }
                
                Section {
                    Text(convertedValue, format: .number)
                } header: {
                    Text("Result")
                }
                
            }.navigationTitle("iUnits")
        }
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
