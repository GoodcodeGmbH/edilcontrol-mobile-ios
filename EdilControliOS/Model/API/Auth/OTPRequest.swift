//
//  OTPRequest.swift
//  EdilControliOS
//
//  Created by Goodcode M2 on 21.12.23.
//

struct OTPRequest: Codable {
    let username: String
    let password: String
    let session: String
    let otp: String
    let applicationId: String
}
