//
//  ContentView.swift
//  iExpense
//
//  Created by nfls on 02/06/2023.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var expenses = Expenses()
    @State private var showingAddView = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                                .font(.caption)
                        }
                        Spacer()
                        Text(item.amount, format: .currency(code: "EUR"))
                    }
                }
                .onDelete(perform: deleteItemsWith)
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    showingAddView = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddView) {
                AddView(expenses: expenses)
            }
        }
    }
    
    
    func deleteItemsWith(indexSet: IndexSet) {
        expenses.items.remove(atOffsets: indexSet)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
