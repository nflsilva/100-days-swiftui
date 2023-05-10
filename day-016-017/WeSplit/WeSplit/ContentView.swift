//
//  ContentView.swift
//  WeSplit
//
//  Created by nfls on 08/05/2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var mealPrice = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 10
    
    @FocusState private var mealPriceIsFocus: Bool
    
    private let currencyCode = Locale.current.currencyCode ?? "EUR"
    private let tipPercentages = [10, 15, 20, 25, 0]

    var totalPerPerson: Double {
        let tipValue = mealPrice / 100 * Double(tipPercentage)
        let totalAmount = mealPrice + tipValue
        return totalAmount / Double(numberOfPeople + 2)
    }
    
    var body: some View {
        NavigationView {
            Form {
               
                Section {
                    TextField("Meal Price",
                              value: $mealPrice,
                              format: .currency(code: currencyCode))
                        .keyboardType(.decimalPad)
                        .focused($mealPriceIsFocus)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                } header: {
                    Text("Meal price")
                }
                
                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Gratitude tip")
                }
                
                Section {
                    Text(totalPerPerson, format: .currency(code: currencyCode))
                }
                
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        mealPriceIsFocus = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
