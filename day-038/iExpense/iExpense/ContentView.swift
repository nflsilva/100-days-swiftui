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
                ItemsSection(expenses: expenses, header: "Business")
                ItemsSection(expenses: expenses, header: "Personal")
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
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
