//
//  ItemsSection.swift
//  iExpense
//
//  Created by nfls on 03/06/2023.
//

import SwiftUI


struct ItemsSection: View{
    
    @StateObject var expenses: Expenses
    let header: String
    
    var body: some View {
        Section {
            ForEach(expenses.items.filter { $0.type == header }) { item in
                HStack {
                    VStack(alignment: .leading) {
                        Text(item.name)
                            .font(.headline)
                    }
                    Spacer()
                    Text(item.amount, format: .currency(code: Expenses.CURRENCY))
                        .foregroundColor(item.amount < 10.0 ? .green : (item.amount < 100 ? .orange : .red))
                }
            }
            .onDelete(perform: deleteItemsWith)
        } header: {
            Text(header)
                .font(.headline)
        }
    }
    
    func deleteItemsWith(indexSet: IndexSet) {
        var idsToRemove = [UUID]()
        let items = expenses.items.filter { $0.type == header }
        
        indexSet.forEach {
            idsToRemove.append(items[$0].id)
        }
        
        expenses.items.removeAll(where: { idsToRemove.contains($0.id) })

    }
}

struct ItemsSection_Previews: PreviewProvider {
    static var previews: some View {
        ItemsSection(expenses: Expenses(), header: "Headline")
    }
}
