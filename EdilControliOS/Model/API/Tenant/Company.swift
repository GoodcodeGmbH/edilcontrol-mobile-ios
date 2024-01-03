//
//  Company.swift
//  EdilControliOS
//
//  Created by Goodcode M2 on 03.01.24.
//

struct Company: Decodable {
    let name: String?
    let vatRegistration: String?
    let address: Address?
    let contactEmail: String?
    let phone: String?
}
