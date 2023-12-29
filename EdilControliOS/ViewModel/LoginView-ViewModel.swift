//
//  LoginView-ViewModel.swift
//  EdilControliOS
//
//  Created by Goodcode M2 on 21.12.23.
//

import Foundation

extension ContentView {
    
    @MainActor class ViewModel: ObservableObject {
        
        @Published var authSession: AuthSession?
        @Published var otpRequestResponse: OTPRequestResponse?
        
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
                    otpRequestResponse = OTPRequestResponse(response: responseString)
                } else {
                    print("Could not convert data to string")
                }
            } catch {
                print("Network request error: \(error.localizedDescription)")
            }

        }
    }
}
