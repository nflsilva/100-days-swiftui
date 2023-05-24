//
//  ContentView.swift
//  Animations
//
//  Created by nfls on 23/05/2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isRed = false
    @State private var scaleAmmount = 1.0
    @State private var rotateAmmount = 0.0
    @State private var buttonDragAmmount = CGSize.zero
    
    let letters = Array("Hello, SwiftUI")
    @State private var lettersToggle = true
    @State private var lettersDragAmmount = CGSize.zero
    
    
    var body: some View {
        
        VStack(spacing: 10) {
            
            // Letters
            HStack {
                ForEach(0..<letters.count) { num in
                    Text(String(letters[num]))
                        .padding(2)
                        .font(.title)
                        .background(lettersToggle ? .blue : .red)
                        .offset(lettersDragAmmount)
                        .animation(
                            .default.delay(Double(num) / 20),
                            value: lettersDragAmmount
                        )
                }
            }
            .gesture(
                DragGesture()
                    .onChanged {
                        lettersDragAmmount = $0.translation
                    }
                    .onEnded { _ in
                        withAnimation {
                            lettersDragAmmount = CGSize.zero
                        }
                        lettersToggle.toggle()
                    }
            )
            
            // Button
            Button("Tap me!") {
                withAnimation(.interactiveSpring()) {
                    rotateAmmount += 360
                }
                withAnimation {
                    isRed.toggle()
                }
            }
            .padding(50)
            .background(isRed ? .red : .blue)
            .animation(.default, value: isRed)
            .foregroundColor(.white)
            .font(.headline)
            .clipShape(RoundedRectangle(cornerRadius: isRed ? 30 : 0))
            .animation(.interpolatingSpring(stiffness: 10, damping: 1), value: isRed)
            .rotation3DEffect(.degrees(rotateAmmount), axis: (x: 0, y: 1, z: 0))
            .shadow(color: .black, radius: 10, x: 5, y: 5)
            .overlay(
                Circle()
                    .stroke(.red)
                    .scaleEffect(scaleAmmount)
                    .opacity(2 - scaleAmmount)
                    .animation(
                        .easeOut(duration: 1)
                            .repeatForever(autoreverses: false),
                        value: scaleAmmount
                    )
            )
            .offset(buttonDragAmmount)
            .onAppear {
                scaleAmmount = scaleAmmount + 1
            }
            .gesture(
                DragGesture()
                    .onChanged {
                        buttonDragAmmount = $0.translation
                    }
                    .onEnded { _ in
                        withAnimation {
                            buttonDragAmmount = CGSize.zero
                        }
                    }
            )
            
            // Square
            if isRed {
                Text("Hello Pat!")
                    .foregroundColor(.white)
                    .frame(width: 200, height: 200)
                    .background(.red)
                    .transition(.asymmetric(insertion: .scale, removal: .opacity))
            }

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
