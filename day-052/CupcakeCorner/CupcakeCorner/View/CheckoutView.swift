//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by nfls on 14/06/2023.
//

import SwiftUI

struct CheckoutView: View {
    
    @StateObject var orderWrapper: OrderWrapper
    @State private var confirmationTitle = ""
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    @State private var isPerformingRequest = false
    
    var body: some View {
        ZStack {
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
                
                Text("Your total is: \(orderWrapper.order.cost, format: .currency(code: "EUR"))")
                    .font(.title)
                
                Button("Place Order") {
                    Task {
                        await placeOrder()
                    }
                }
                .padding()
                
                Spacer()
            }
            if isPerformingRequest {
                VStack {
                    ProgressView()
                    Text("Placing your order...")
                        .padding()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.ultraThinMaterial)
                .ignoresSafeArea()
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarHidden(isPerformingRequest)
        .alert(confirmationTitle, isPresented: $showingConfirmation) {
            Button("OK") { }
        } message: {
            Text(confirmationMessage)
        }
    }
    
    private func placeOrder() async {
        guard let encodedData = try? JSONEncoder().encode(orderWrapper.order) else {
            print("Failed to encode order")
            return
        }
        
        withAnimation {
            isPerformingRequest = true
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        // simulate delay
        for i in 0...200000 {
            print(i)
        }
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encodedData)
            
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage = "You placed an order for \(decodedOrder.cost)"
            confirmationTitle = "Thank you!"
            showingConfirmation = true
        } catch {
            confirmationMessage = "Connection error. Try again later."
            confirmationTitle = "Ooops!"
            showingConfirmation = true
        }
        
        withAnimation {
            isPerformingRequest = false
        }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(orderWrapper: OrderWrapper())
    }
}
