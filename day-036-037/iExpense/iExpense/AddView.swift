//
//  AddView.swift
//  iExpense
//
//  Created by nfls on 02/06/2023.
//

import SwiftUI

struct AddView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var expenses: Expenses
    
    @State private var name = ""
    @State private var typeId = 0
    @State private var amount = 0.0
    
    private let types = ["Business", "Personal"]
    
    var body: some View {
        NavigationView {
            Form {
                
                TextField("Name", text: $name)
                
                Picker("Type", selection: $typeId) {
                    ForEach(0..<types.count) {
                        Text(types[$0])
                    }
                }
                
                TextField("Ammount", value: $amount, format: .currency(code: "EUR"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add new expense")
            .toolbar {
                Button("Create") {
                    let newExpense = ExpenseItem(name: name, type: types[typeId], amount: amount)
                    expenses.items.append(newExpense)
                    dismiss()
                }
            }
        }
        
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
