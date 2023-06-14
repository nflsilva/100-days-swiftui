//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by nfls on 14/06/2023.
//

import SwiftUI

struct CheckoutView: View {
    
    @StateObject var order: Order
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"),
                       scale: 3) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .frame(height: 233)
            
            Text("Your total is: \(order.cost, format: .currency(code: "EUR"))")
                .font(.title)
            
            Button("Place Order") {
                Task {
                    await placeOrder()
                }
            }
            .padding()
            
            Spacer()
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Thank you!", isPresented: $showingConfirmation) {
            Button("OK") { }
        } message: {
            Text(confirmationMessage)
        }
    }
    
    private func placeOrder() async {
        guard let encodedData = try? JSONEncoder().encode(order) else {
            print("Failed to encode order")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encodedData)
            
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage = "You placed an order for \(decodedOrder.cost)"
            showingConfirmation = true
        } catch {
            print("Checkout failed.")
        }
        
        
        
        
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
