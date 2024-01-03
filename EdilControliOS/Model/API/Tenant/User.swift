//
//  User.swift
//  EdilControliOS
//
//  Created by Goodcode M2 on 03.01.24.
//

struct User: Decodable {
    let id: String?
    let firstName: String?
    let lastName: String?
    let mobilePhone: String?
    let phone: String?
    let avatar: String?
    let role: String?
    let address: String?
    let zipCode: String?
    let city: String?
    let country: String?
    let email: String?
    let password: String?
    let changePasswordOnLogin: Bool?
    let passwordResetToken: String?
    let passwordResetExpire: String?
    let createdAt: String?
    let updatedAt: String?
    let enabled: Bool?
    let accountNonLocked: Bool?
    let username: String?
    let credentialsNonExpired: Bool?
    let accountNonExpired: Bool?
    let authorities: [Authority]?
}
