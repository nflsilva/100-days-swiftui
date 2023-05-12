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

    var total: Double {
        let tipValue = mealPrice / 100 * Double(tipPercentage)
        let totalAmount = mealPrice + tipValue
        return totalAmount
    }
    
    var totalPerPerson: Double {
        return total / Double(numberOfPeople + 2)
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
                        ForEach(0..<101) {
                            Text($0, format: .percent)
                        }
                    }
                } header: {
                    Text("Gratitude tip")
                }
                
                Section {
                    Text(total, format: .currency(code: currencyCode))
                        .foregroundColor(tipPercentage == 0 ? .red : .black)
                } header: {
                    Text("Total")
                }
                
                Section {
                    Text(totalPerPerson, format: .currency(code: currencyCode))
                } header: {
                    Text("Total per person")
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
