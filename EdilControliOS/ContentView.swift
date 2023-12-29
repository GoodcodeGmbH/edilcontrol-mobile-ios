//
//  ContentView.swift
//  EdilControliOS
//
//  Created by Goodcode M2 on 18.12.23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = ViewModel()
    @State private var email: String = ""
    
    var body: some View {
        VStack {
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
        .onAppear(
            perform: {
                Task {
                    await viewModel.getAuthSession()
                }
            })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
