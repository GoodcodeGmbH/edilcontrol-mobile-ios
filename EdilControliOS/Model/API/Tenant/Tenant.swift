//
//  Tenant.swift
//  EdilControliOS
//
//  Created by Goodcode M2 on 03.01.24.
//

struct Tenant: Decodable, Identifiable {
    let id: String?
    let user: User?
    let application: Application?
    let email: String?
    let phone: String?
    let createdAt: String?
    let updatedAt: String?
}
