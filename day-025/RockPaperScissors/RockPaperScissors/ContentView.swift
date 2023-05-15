//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by nfls on 13/05/2023.
//

import SwiftUI

struct HandSelectionImage: View {
    let image: String

    var body: some View {
        ZStack {
            Image(image)
                .resizable()
                .scaledToFit()
        }
        .padding(15)
        .background(.white)
        .clipShape(Capsule())
        .shadow(color: .black, radius: 10, x: 10, y: 10)
    }
}

struct ContentView: View {
    
    private let gestures = ["scissors", "rock", "paper"]
    
    @State private var cpuGesture = Int.random(in: 0..<3)
    @State private var score = 0
    @State private var roundNumber = 0
    @State private var playToWin = false
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]),
                           startPoint: .topLeading,
                           endPoint: .bottomTrailing)
                .ignoresSafeArea()
                .frame(maxWidth: .infinity)
            
            VStack(spacing: 75) {
                
                VStack {
                    Text("Play to")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                    Text(playToWin ? "Win!" : "Lose!")
                        .font(.largeTitle).bold()
                        .foregroundColor(playToWin ? .green : .red)
                }

                HStack {
                    HandSelectionImage(image: gestures[cpuGesture])
                }
                
                HStack(spacing: 25) {
                    Spacer()
                    ForEach(0..<3) { gestureId in
                        Button {
                            selectGesture(gestureId)
                        } label: {
                            HandSelectionImage(image: gestures[gestureId])
                        }
                        
                    }
                    Spacer()
                }
                HStack {
                    Text("Score: \(score)")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                }
            }
        }
    }
    
    private func selectGesture(_ gestureId: Int) {
        if cpuGesture != gestureId {
            let nextId = (cpuGesture + 1) % 3
            let gestureWins = gestureId == nextId
            let wonRound = (playToWin && gestureWins) || (!playToWin && !gestureWins)
            
            if wonRound {
                score += 1
            }
            else {
                score -= 1
            }
        }
        goTonextRound()
    }
    
    private func goTonextRound() {
        let rng = Int.random(in: 0...9)
        playToWin = rng > 5
        roundNumber += 1
        cpuGesture = Int.random(in: 0..<3)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
