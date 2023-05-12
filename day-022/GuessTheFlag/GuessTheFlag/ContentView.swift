//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Nelson Silva on 11/05/2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var normalAlertIsPresented: Bool = false
    @State private var finalAlertIsPresented: Bool = false
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var alertTitle = "Wrong"
    @State private var alertText = "Wrong"
    @State private var score = 0
    @State private var questionNumber = 1
    
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
                                let wasLastQuestion = questionNumber == 8
                                normalAlertIsPresented = !wasLastQuestion
                                finalAlertIsPresented = wasLastQuestion
                                
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
        .alert(alertTitle, isPresented: $normalAlertIsPresented) {
            Button("Continue", role: .cancel) {
                askQuestion()
            }
        } message: {
            Text(alertText)
        }
        .alert("Game Over!", isPresented: $finalAlertIsPresented) {
            Button("Yes", role: .destructive) {
                reset()
            }
        } message: {
            Text(alertText)
        }
    }
    
    private func reset() {
        questionNumber = 1
        score = 0
        normalAlertIsPresented = false
        finalAlertIsPresented = false
        askQuestion()
    }
    
    private func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        questionNumber += 1
    }
    
    private func answearQuestion(_ responde: Int) {
        if responde == correctAnswer {
            score += 1
            alertTitle = "Well done!"
            alertText = "Score:\(score)"
        }
        else {
            score -= 1
            alertTitle = "Wrong"
            alertText = "That was \(countries[responde]) flag."
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
