//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by nfls on 14/06/2023.
//

import SwiftUI

struct AddressView: View {
    
    @StateObject var order: Order
    
    var body: some View {
        Form {
            
            Section {
                TextField("Name", text: $order.name)
                TextField("Street name", text: $order.streetName)
                TextField("City", text: $order.city)
                TextField("Zipcode", text: $order.zipcode)
            }
            
            Section {
                NavigationLink {
                    CheckoutView(order: order)
                } label: {
                    Text("Check out")
                }
            }
            .disabled(order.hasInvalidAddress)
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Delivery details")
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: Order())
            .preferredColorScheme(.dark)
    }
}
