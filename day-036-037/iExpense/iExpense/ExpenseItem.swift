//
//  ExpenseItem.swift
//  iExpense
//
//  Created by nfls on 02/06/2023.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
