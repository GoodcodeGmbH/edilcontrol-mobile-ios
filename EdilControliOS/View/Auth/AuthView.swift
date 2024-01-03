//
//  ContentView.swift
//  EdilControliOS
//
//  Created by Goodcode M2 on 18.12.23.
//

import SwiftUI

struct AuthView: View {
    
    @EnvironmentObject private var viewModel: AuthView.ViewModel
    @State private var email: String = ""
    @State private var navigateToOTPView = false
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: OTPView(), isActive: $navigateToOTPView) {
                           EmptyView()
                }
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                VStack(spacing: 12) {
                    TextField("Email address", text: $email)
                        .textFieldStyle(.roundedBorder)
                    Button {
                        Task {
                            do {
                                await viewModel.requestOTP(username: email, password: "", authSession: viewModel.authSession ?? AuthSession(session: ""), otp: "", applicationId: "")
                                
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
                    await viewModel.getAuthSession()
                }
            }
        }
        .navigationDestination(isPresented: $navigateToOTPView, destination: {
            OTPView()
        })
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
