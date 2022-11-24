//
//  Expenses.swift
//  NC1
//
//  Created by Sofia Esposito on 24/11/22.
//
import SwiftUI

// MARK: Expense Model and Sample Data

struct Expense: Identifiable{
    var id = UUID().uuidString
    var amountSpent: String
    var product: String
    var productIcon: String
    var spendType: String
}

var expenses: [Expense] = [

    Expense(amountSpent: "128$" , product: "Amazon", productIcon: "Amazon Icon", spendType: "Groceries"),
    Expense(amountSpent: "336$", product: "Apple", productIcon: "Apple Icon", spendType: "Apple Watch"),
    Expense(amountSpent: "36$", product: "Disney+", productIcon: "Disney+ icon", spendType: "Streaming"),
    Expense(amountSpent: "18$", product: "Netflix", productIcon: "Netflix Icon", spendType: "Streaming"),
    Expense(amountSpent: "125,90$", product: "Italo", productIcon: "Italo icon", spendType: "Journey"),
    Expense(amountSpent: "456$", product: "SHEIN", productIcon: "Shein icon", spendType: "Shopping")
    
]
