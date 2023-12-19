//
//  ContentView.swift
//  EdilControliOS
//
//  Created by Goodcode M2 on 18.12.23.
//

import SwiftUI

struct ContentView: View {
    
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
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
