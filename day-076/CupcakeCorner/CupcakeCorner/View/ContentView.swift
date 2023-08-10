//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by nfls on 14/06/2023.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var orderWrapper = OrderWrapper()
    
    var body: some View {
        
        NavigationView {
            Form {
                
                Section {
                    Picker("Select your cake type:", selection: $orderWrapper.order.cupcakeTypeIndex) {
                        ForEach(Order.cupcakeTypes.indices) {
                            Text(Order.cupcakeTypes[$0])
                        }
                    }
                    
                    Stepper("Number of cakes: \(orderWrapper.order.numberOfCakes)",
                            value: $orderWrapper.order.numberOfCakes,
                            in: 1...10,
                            step: 1)
                }
                
                Section {
                    Toggle("Any special requests?", isOn: $orderWrapper.order.hasSpecialRequest.animation())
                    if orderWrapper.order.hasSpecialRequest {
                        Toggle("Add extra frosting?", isOn: $orderWrapper.order.hasSpecialFrosting)
                        Toggle("Add extra sprinkles?", isOn: $orderWrapper.order.hasExtraSprinkles)
                    }
                }
                
                Section {
                    NavigationLink {
                        AddressView(orderWrapper: orderWrapper)
                    } label: {
                        Text("Delivery details")
                    }
                }
                
            }
            .navigationTitle("Cupcake Corner")
            .padding(.top)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
