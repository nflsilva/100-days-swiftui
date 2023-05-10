//
//  ContentView.swift
//  iUnits
//
//  Created by Nelson Silva on 10/05/2023.
//

import SwiftUI

struct ContentView: View {
    
    private static let conversions = [
        "Temperature" : ["Celsius", "Fahrenheit", "Kelvin"],
        "Length": ["Meters", "Kilometers", "Feet", "Yards", "Miles"],
        "Time": ["Seconds", "Minutes", "Hours", "Days"],
        "Volume": ["Milliliters", "Liters", "Cups", "Pints", "Gallons"]
    ]
    
    @State var valueToConvert = 0.0
    @State var selectedConversion = "Temperature"
    @State var selectedConversionFromUnit = "Celsius"
    @State var selectedConversionToUnit = "Fahrenheit"
    @FocusState private var mealPriceIsFocus: Bool
    
    private var selectedUnits: [String] {
        return ContentView.conversions[selectedConversion] ?? []
    }
    private var convertedValue: Double {
        return valueToConvert
    }
    
    
    
    var body: some View {
        NavigationView {
            Form {
                
                Section {
                    Picker("Conversions", selection: $selectedConversion) {
                        ForEach(ContentView.conversions.keys.compactMap { $0 }, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    .keyboardType(.numberPad)
                    TextField("Value to convert", value: $valueToConvert, format: .number)
                } header: {
                    Text("Converting units")
                }
                
                Section {
                    Picker("Conversions", selection: $selectedConversionFromUnit) {
                        ForEach(selectedUnits, id: \.self) {
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
                        ForEach(selectedUnits, id: \.self) {
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
