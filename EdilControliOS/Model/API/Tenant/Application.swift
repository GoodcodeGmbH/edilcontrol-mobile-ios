//
//  Application.swift
//  EdilControliOS
//
//  Created by Goodcode M2 on 03.01.24.
//

struct Application: Decodable {
    let id: String?
    let logo: String?
    let name: String?
    let domain: String?
    let plan: Plan?
    let user: User?
    let stripeCustomerId: String?
    let company: Company?
    let urlSettings: URLSettings?
    let status: String?
    let billing: String?
    let appName: String?
    let createdAt: String?
    let updatedAt: String?
}
