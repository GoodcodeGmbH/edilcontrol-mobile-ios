//
//  ContentView.swift
//  EdilControliOS
//
//  Created by Goodcode M2 on 18.12.23.
//

import SwiftUI

struct AuthView: View {
    
    @EnvironmentObject private var loginViewModel: LoginViewModel
    @State private var email: String = ""
    @State private var navigateToOTPView = false
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: OTPView().environmentObject(loginViewModel).navigationBarBackButtonHidden(true), isActive: $navigateToOTPView) {
                    EmptyView()
                }
                Image("EdilControlLogo")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                VStack(spacing: 12) {
                    TextField("Email address", text: $email)
                        .textFieldStyle(.roundedBorder)
                    Button {
                        Task {
                            do {
                                // save username in view model from user input text field
                                loginViewModel.username = email
                                
                                // perform otp request
                                await loginViewModel.requestOTP(username: email, password: "", authSession: loginViewModel.authSession ?? AuthSession(session: ""), otp: "", applicationId: "")
                                
                                // change bool value to navigate to fragment otp
                                navigateToOTPView = true
                            }
                        }
                    } label: {
                        Text("Send OTP")
                            .fontWeight(Font.Weight.semibold)
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                }
                .padding()
                .frame(maxWidth: .infinity)
            }
            .frame(maxWidth: 450)
            .onAppear {
                Task {
                    await loginViewModel.getAuthSession()
                }
            }
        }
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
