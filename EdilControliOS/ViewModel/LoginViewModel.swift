//
//  LoginViewModel.swift
//  EdilControliOS
//
//  Created by Goodcode M2 on 21.12.23.
//

import Foundation

class LoginViewModel: ObservableObject {
        
    @Published var username: String?
    @Published var authSession: AuthSession?
    @Published var otpRequestResponse: OTPRequestResponse?
    @Published var otpValidateResponse: OTPValidateResponse?
    @Published var tenantList: [Tenant] = []
        
    func getAuthSession() async {
            
        guard let url = URL(string: "http://127.0.0.1:5001/api/v1/auth/session") else {
            print("Invalid URL")
            return
        }
            
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
                
            if let error = error {
                print("Error: \(error)")
                    
                return
            }
                
            guard let httpResponse = response as? HTTPURLResponse,
                    (200...299).contains(httpResponse.statusCode) else {
                print("Unsuccessful response")
                    
                return
            }
                
            if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode(AuthSession.self, from: data)
                        
                    DispatchQueue.main.async {
                        self.authSession = decodedData
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
        }
            
        task.resume()
    }
        
    func requestOTP(username: String, password: String, authSession: AuthSession, otp: String, applicationId: String) async {
            
        guard let url = URL(string: "http://127.0.0.1:5001/api/v1/auth/otp/request") else {
            print("Invalid URL")
            
            return
        }
            
        let otpRequest = OTPRequest(username: username, password: password, session: authSession.session, otp: otp, applicationId: applicationId)
            
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
        do {
            let jsonData = try JSONEncoder().encode(otpRequest)
            request.httpBody = jsonData
        } catch let error {
            print("JSON encoding error: \(error.localizedDescription)")
                
            return
        }
            
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
                
            if let responseString = String(data: data, encoding: .utf8) {
                DispatchQueue.main.async {
                    self.otpRequestResponse = OTPRequestResponse(response: responseString)
                }
            } else {
                print("Could not convert data to string")
            }
        } catch {
            print("Network request error: \(error.localizedDescription)")
        }
    }
    
    func validateOTP(username: String, password: String, authSession: AuthSession, otp: String, applicationId: String, completion: @escaping () async -> Void) async {
        
        let otpValidate = OTPValidate(
            username: username,
            password: password,
            session: authSession.session,
            otp: otp,
            applicationId: applicationId
        )
            
        guard let url = URL(string: "http://127.0.0.1:5001/api/v1/auth/otp/validate") else {
            print("Invalid URL")
            
            return
        }
            
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
        do {
            let jsonData = try JSONEncoder().encode(otpValidate)
            request.httpBody = jsonData
        } catch {
            print("Error encoding OTPValidate object: \(error.localizedDescription)")
            
            return
        }
            
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                    print("Error: \(error?.localizedDescription ?? "Unknown error")")
                    
                return
            }
                
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                do {
                    let otpResponse = try JSONDecoder().decode(OTPValidateResponse.self, from: data)
                    
                    DispatchQueue.main.async {
                        self.otpValidateResponse = otpResponse
                        
                        Task {
                            await completion()
                        }
                    }
                } catch {
                    print("Error decoding OTPValidateResponse: \(error.localizedDescription)")
                }
            } else {
                if let responseData = String(data: data, encoding: .utf8) {
                        print("POST (otp/validate): \(responseData)")
                } else {
                        print("POST (otp/validate): Body is null")
                }
            }
        }.resume()
    }
    
    func getTenantList(completion: @escaping () -> Void) async {
        
        guard let token = otpValidateResponse?.token else {
            // handle case token unavailable
            return
        }
            
        let url = URL(string: "http://127.0.0.1:5001/api/v1/tenant/user/self")!
            
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, let httpResponse = response as? HTTPURLResponse, error == nil else {
                // handle error
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                
                return
            }
                
            if (200..<300).contains(httpResponse.statusCode) {
                do {
                    let decodedData = try JSONDecoder().decode([Tenant].self, from: data)
                    
                    DispatchQueue.main.async {
                        self.tenantList = decodedData
                        
                        print(self.tenantList.count)
                        
                        print(self.tenantList[0])
                        
                        completion()
                    }
                } catch {
                    // handle decoding error
                    print("Error decoding JSON: \(error)")
                }
            } else {
                // handle unsuccessful response
                print("UNSUCCESSFUL RESPONSE! GET (tenant/self): \(String(data: data, encoding: .utf8) ?? "")")
            }
        }.resume()
    }
}
