//
//  GamePlayView.swift
//  iTimesTables
//
//  Created by nfls on 27/05/2023.
//

import SwiftUI

struct GamePlayView: View {
    
    let numberOfQuestions: Int
    let timesTable: Int
    let onDoneClick: () -> ()
    
    @State private var correctAnswear = 0
    @State private var questionNumber = 0
    @State private var correctAnsweres = 0
    @State private var multiplier = 0
    @State private var showingResultAlert = false
    @State private var possibleAnswears = [0, 0, 0, 0, 0, 0]

    var body: some View {
        ZStack {
            
            LinearGradient(colors: [.red, .orange],
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .ignoresSafeArea()
                .frame(minWidth: 0,
                       maxWidth: .infinity,
                       minHeight: 0,
                       maxHeight: .infinity,
                       alignment: .center)

            VStack {
                
                HStack(spacing: 20) {
                    Spacer()
                    Text("Question \(questionNumber) of \(numberOfQuestions)")
                        .font(.headline)
                        .foregroundColor(.black)
                    Spacer()
                    Spacer()
                    Text("Score \(correctAnsweres)")
                        .font(.headline)
                        .foregroundColor(.black)
                    Spacer()
                }
                Spacer()

                VStack(spacing:25) {
                    Text("How much is: ")
                        .font(.largeTitle)
                        .foregroundColor(.black)
                    
                    HStack {
                        Text("\(multiplier)")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.red)
                        Text(" x ")
                        Text("\(timesTable)")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                    }
                    .padding(30)
                    .background(.thickMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 10))

                    VStack {
                        Text("Answears")
                            .font(.headline)
                            .foregroundColor(.black)

                        HStack(spacing: 10) {
                            ForEach(0..<possibleAnswears.count) { a in
                                Button(action: {
                                    answearQuestionWith(answear: possibleAnswears[a])
                                }, label: {
                                    Text("\(possibleAnswears[a])")
                                        .foregroundColor(.primary)
                                })
                                .frame(width: 40, height: 50, alignment: .center)
                                .font(.body)
                                .background(.thickMaterial)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                        }

                    }
                    .padding(50)
                    
                }
                .onAppear {
                    askQuestion()
                }
                
                Spacer()
            }

        }
    }
    
    private func askQuestion() {
        questionNumber += 1
        multiplier = Int.random(in: 1..<11)
        correctAnswear = multiplier * timesTable
        let correctAnswearIndex = Int.random(in: 0..<possibleAnswears.count)
        var incorrectAnswears = Set<Int>()
        for i in 0..<possibleAnswears.count {
            var incorrectAnswear = correctAnswear
            
            while incorrectAnswear == correctAnswear || incorrectAnswears.contains(incorrectAnswear) {
                incorrectAnswear = timesTable * Int.random(in: 1..<11)
            }

            incorrectAnswears.insert(incorrectAnswear)
            
            possibleAnswears[i] = i == correctAnswearIndex ? correctAnswear : incorrectAnswear
        }
        showingResultAlert = false
    }
    
    private func answearQuestionWith(answear: Int) {
        
        if answear == correctAnswear {
            correctAnsweres += 1
        }
        
        if questionNumber == numberOfQuestions {
            onDoneClick()
        }
        else {
            askQuestion()
        }
    }
    
}

struct GamePlayView_Previews: PreviewProvider {
    static var previews: some View {
        GamePlayView(numberOfQuestions: 5, timesTable: 5) {}
    }
}
