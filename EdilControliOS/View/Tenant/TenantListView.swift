//
//  TenantListView.swift
//  EdilControliOS
//
//  Created by Goodcode M2 on 03.01.24.
//

import SwiftUI


struct TenantListView: View {
    
    @EnvironmentObject private var loginViewModel: LoginViewModel
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Seleziona un tenant")) {
                    ForEach(loginViewModel.tenantList, id: \.id) { tenant in
                        ItemTenantList(tenant: tenant)
                            .padding(8)
                    }
                }
            }
        }
        .navigationTitle("Tenant")
        .navigationBarTitleDisplayMode(.inline)
    }
}
