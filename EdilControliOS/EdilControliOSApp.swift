//
//  EdilControliOSApp.swift
//  EdilControliOS
//
//  Created by Goodcode M2 on 18.12.23.
//

import SwiftUI

@main
struct EdilControliOSApp: App {
    
    @StateObject var viewModel = LoginViewModel()
    
    var body: some Scene {
        WindowGroup {
            AuthView()
                .environmentObject(viewModel)
        }
    }
}
