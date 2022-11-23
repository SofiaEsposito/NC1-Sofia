//
//  Card.swift
//  NC1
//
//  Created by Sofia Esposito on 23/11/22.
//

import SwiftUI

// MARK: Semple Card Model and Data

struct Card: Identifiable{
    var id = UUID().uuidString
    var name: String
    var cardNumber: String
    var cardImage: String
    var cardDeadline: String
}
var cards: [Card] = [

Card(name: "Luigi", cardNumber: "4873 7002 8921 3001", cardImage: "Card 1", cardDeadline: "09/26"),
Card(name: "Sara", cardNumber: "8943 4590 0002 6341", cardImage: "Card 2", cardDeadline: "11/23"),
Card(name: "Philip", cardNumber: "6573 2298 5561 4309", cardImage: "Card 3", cardDeadline: "12/24"),
]

