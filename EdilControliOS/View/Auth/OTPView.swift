//
//  OTPView.swift
//  EdilControliOS
//
//  Created by Goodcode M2 on 29.12.23.
//

import Foundation
import SwiftUI

struct OTPView: View {
    
    @EnvironmentObject private var viewModel: AuthView.ViewModel
    @State private var otp: String = ""
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            VStack(spacing: 12) {
                TextField("OTP Code", text: $otp)
                    .keyboardType(.numberPad)
                    .textFieldStyle(.roundedBorder)
                    .onChange(of: otp, perform: { newValue in
                        let filtered = newValue.filter { "0123456789".contains($0) }
                        if filtered.count > 6 {
                            self.otp = String(filtered.prefix(6))
                        } else {
                            self.otp = filtered
                        }
                    })
                Button {
                    Task {
                        do {
                            /*await viewModel.requestOTP(username: email, password: "", authSession: viewModel.authSession ?? AuthSession(session: ""), otp: "", applicationId: "") */
                        }
                    }
                } label: {
                    Text("Validate OTP")
                        .fontWeight(Font.Weight.semibold)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
            .frame(maxWidth: .infinity)
        }
        .frame(maxWidth: 450)
    }
}

struct OTPView_Previews: PreviewProvider {
    static var previews: some View {
        OTPView()
    }
}
