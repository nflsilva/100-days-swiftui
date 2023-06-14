//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by nfls on 14/06/2023.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var order = Order()
    
    var body: some View {
        
        NavigationView {
            Form {
                
                Section {
                    Picker("Select your cake type:", selection: $order.cupcakeTypeIndex) {
                        ForEach(Order.cupcakeTypes.indices) {
                            Text(Order.cupcakeTypes[$0])
                        }
                    }
                    
                    Stepper("Number of cakes: \(order.numberOfCakes)",
                            value: $order.numberOfCakes,
                            in: 1...10,
                            step: 1)
                }
                
                Section {
                    Toggle("Any special requests?", isOn: $order.hasSpecialRequest.animation())
                    if order.hasSpecialRequest {
                        Toggle("Add extra frosting?", isOn: $order.hasSpecialFrosting)
                        Toggle("Add extra sprinkles?", isOn: $order.hasExtraSprinkles)
                    }
                }
                
                Section {
                    NavigationLink {
                        AddressView(order: order)
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
