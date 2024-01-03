//
//  OTPView.swift
//  EdilControliOS
//
//  Created by Goodcode M2 on 29.12.23.
//

import Foundation
import SwiftUI

struct OTPView: View {
    
    @EnvironmentObject private var loginViewModel: LoginViewModel
    @State private var otp: String = ""
    @State private var navigateToTenantListView = false
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: TenantListView().environmentObject(loginViewModel).navigationBarBackButtonHidden(true), isActive: $navigateToTenantListView) {
                    EmptyView()
                }
                Image(Constant.edilControlLogo)
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
                                // perform validate otp
                                await loginViewModel.validateOTP(username: loginViewModel.username!, password: "", authSession: loginViewModel.authSession ?? AuthSession(session: ""), otp: otp, applicationId: "") {
                                    
                                    // retrieve tenant list only if successful validate otp api call
                                    await loginViewModel.getTenantList {
                                        // change bool value to navigate to tenant list
                                        navigateToTenantListView = true
                                    }
                                }
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
}

struct OTPView_Previews: PreviewProvider {
    static var previews: some View {
        OTPView()
    }
}
