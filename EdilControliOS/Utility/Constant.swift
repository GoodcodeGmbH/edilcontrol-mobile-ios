//
//  Constant.swift
//  EdilControliOS
//
//  Created by Goodcode M2 on 03.01.24.
//

struct Constant {
    static let edilControlLogo = "EdilControlLogo"
    
    // auth
    static let authUrl = "http://127.0.0.1:5001/api/v1/auth/"
    static let sessionEndpoint = "session"
    static let otpRequestEndpoint = "otp/request"
    static let otpValidateEndpoint = "otp/validate"
    
    // tenant
    static let tenantUrl = "http://127.0.0.1:5001/api/v1/tenant/"
    static let selfEndpoint = "user/self"
    
    // utility for api call
    static let get = "GET"
    static let post = "POST"
    static let applicationJson = "application/json"
    static let contentType = "Content-Type"
    static let bearer = "Bearer"
    static let authorization = "Authorization"
}
