//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Nelson Silva on 11/05/2023.
//

import SwiftUI

extension CGSize {
    static var one: CGSize {
        return CGSize(width: 1.0, height: 1.0)
    }
    init(_ value : Double) {
        self.init()
        width = value
        height = value
    }
}

struct FlagImage: View {
    
    @State var rotation: Double = 0
    
    let image: String
    let onSelection: (_ flag: FlagImage) -> ()
    
    var body: some View {
        Button {
            onSelection(self)
        } label: {
            Image(image)
                .renderingMode(.original)
                .clipShape(Capsule())
                .shadow(radius: 6)
        }
        .rotation3DEffect(.degrees(rotation), axis: (x: 0, y: 1, z: 0))
    }
}

struct BigBlueTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle.bold())
            .foregroundColor(.blue)
    }
}

struct ContentView: View {
    
    @State private var flagWasPressed: Bool = false
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
                    .modifier(BigBlueTitle())
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundColor(.black)
                            .font(.subheadline.weight(.heavy))
                        
                        Text(countries[correctAnswer])
                            .foregroundColor(.black)
                            .font(.largeTitle.weight(.semibold))
                        
                        ForEach(0..<3) { number in
                            FlagImage(image: countries[number]) { flag in
                                answearQuestion(number)
                                flag.rotation += number != correctAnswer ? 0 : 360
                                flagWasPressed = true
                                let wasLastQuestion = questionNumber == 8
                                normalAlertIsPresented = !wasLastQuestion
                                finalAlertIsPresented = wasLastQuestion
                            }
                            .opacity(flagWasPressed && number != correctAnswer ? 0.2 : 1.0)
                            .scaleEffect(flagWasPressed && number != correctAnswer ? CGSize(0.5) : CGSize.one)
                            .animation(.default, value: flagWasPressed)
                            
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
        flagWasPressed = false
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
    
    private func animateButtons() {
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
