//
//  ItemTenantList.swift
//  EdilControliOS
//
//  Created by Goodcode M2 on 03.01.24.
//

import SwiftUI

struct ItemTenantList: View {
    var tenant: Tenant
    
    var body: some View {
        VStack {
            Spacer()
            
            Image(systemName: "globe")
                .resizable()
                .frame(width: 24, height: 24)
                .padding(.top, 4)
                .foregroundColor(.accentColor)
                    
            Text(tenant.application?.name ?? "")
                .font(.title3)
                .fontWeight(.bold)
            
            if let street = tenant.application?.company?.address?.street,
                let city = tenant.application?.company?.address?.city,
               let zipCode = tenant.application?.company?.address?.zipCode {
                
                Text("\(street), \(city), \(zipCode)")
                    .font(.footnote)
            }
                                    
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding(4)
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 8)
    }
}
