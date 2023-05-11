//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Nelson Silva on 11/05/2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var alertIsPresented: Bool = false
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var alertTitle = "Wrong"
    @State private var score = 0
    
    var body: some View {
        ZStack {

            LinearGradient(gradient: Gradient(colors: [.blue, .black]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
            .ignoresSafeArea()
            
            VStack(spacing: 30) {
                Text("Tap the flag of")
                    .foregroundColor(.white)
                
                Text(countries[correctAnswer])
                    .foregroundColor(.white)
                    .bold()
                
                ForEach(0..<3) { number in
                    Button {
                        alertIsPresented = true
                        
                        
    
                    } label: {
                        Image(countries[number])
                            .renderingMode(.original)
                    }
                }
            }
        }
        .alert("hey", isPresented: $alertIsPresented) {
            Button("Continue", role: .cancel) { }
        } message: {
            Text("Hello")
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func answearQuestion(_ responde: Int) {
        if responde == correctAnswer {
            alertTitle = "Correct"
            score += 1
        }
        else {
            alertTitle = "Wrong"
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
