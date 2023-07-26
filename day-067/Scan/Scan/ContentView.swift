//
//  ContentView.swift
//  Scan
//
//  Created by nfls on 26/07/2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var scanOffset = 100.0
    @State private var isAnimating = false
    
    var body: some View {
        ZStack(alignment: .center) {
            
            Image("sample")
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
            
            ZStack {
                Color.black
                    .opacity(0.5)
                    .ignoresSafeArea()
 
                Rectangle()
                    .frame(width: 250, height: 250)
                    .blendMode(.destinationOut)
                    .overlay(
                        Rectangle()
                            .fill(Color.blue)
                            .frame(width: 250, height: 10)
                            .transformEffect(
                                CGAffineTransform.init(translationX: 0, y: isAnimating ? 100 : 0)
                            )
                            .animation(Animation.linear(duration: 1).repeatForever(autoreverses: true))
                            .onAppear {
                                isAnimating = true
                            }
                            
                    )
            }
            .compositingGroup()
 
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
