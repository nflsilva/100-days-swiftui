//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by nfls on 14/06/2023.
//

import SwiftUI

struct AddressView: View {
    
    @StateObject var orderWrapper: OrderWrapper
    
    var body: some View {
        Form {
            
            Section {
                TextField("Name", text: $orderWrapper.order.name)
                TextField("Street name", text: $orderWrapper.order.streetName)
                TextField("City", text: $orderWrapper.order.city)
                TextField("Zipcode", text: $orderWrapper.order.zipcode)
            }
            
            Section {
                NavigationLink {
                    CheckoutView(orderWrapper: orderWrapper)
                } label: {
                    Text("Check out")
                }
            }
            .disabled(orderWrapper.order.hasInvalidAddress)
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Delivery details")
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(orderWrapper: OrderWrapper())
            .preferredColorScheme(.dark)
    }
}
