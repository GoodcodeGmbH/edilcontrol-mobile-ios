//
//  Plan.swift
//  EdilControliOS
//
//  Created by Goodcode M2 on 03.01.24.
//

struct Plan: Decodable {
    let id: String?
    let name: String?
    let serverSize: String?
    let stripeId: String?
    let price: Price?
    let features: [Feature]?
}
