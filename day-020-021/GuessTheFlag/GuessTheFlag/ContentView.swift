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
    @State private var alertText = "Wrong"
    @State private var score = 0
    
    var body: some View {
        ZStack {
            
            LinearGradient(gradient: Gradient(colors: [.blue, .black]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .ignoresSafeArea()
                .frame(maxWidth: .infinity)
            
            VStack {
                Spacer()
                Text("Guess The Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundColor(.black)
                            .font(.subheadline.weight(.heavy))
                        
                        Text(countries[correctAnswer])
                            .foregroundColor(.black)
                            .font(.largeTitle.weight(.semibold))
                        
                        ForEach(0..<3) { number in
                            Button {
                                answearQuestion(number)
                                alertIsPresented = true
                            } label: {
                                Image(countries[number])
                                    .renderingMode(.original)
                                    .clipShape(Capsule())
                                    .shadow(radius: 6)
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                
                Spacer()
                
            }
            .padding()
        }
        .alert(alertTitle, isPresented: $alertIsPresented) {
            Button("Continue", role: .cancel) {
                askQuestion()
            }
        } message: {
            Text(alertText)
        }
    }
    
    private func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    private func answearQuestion(_ responde: Int) {
        if responde == correctAnswer {
            score += 1
            alertTitle = "Well done!"
            alertText = "Score:\(score)"
        }
        else {
            alertTitle = "Wrong"
            alertText = "That was flag number \(correctAnswer)"
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
