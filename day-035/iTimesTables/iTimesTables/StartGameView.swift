//
//  StartGameView.swift
//  iTimesTables
//
//  Created by nfls on 25/05/2023.
//

import SwiftUI

struct StartGameView: View {
    
    let onStartClick: (Int, Int) -> ()
    
    private let numberOfQuestionsOptions = [5, 10, 20]
    
    @State private var timesTable: Int = 2
    @State private var numberOfQuestions: Int = 5
    
    var body: some View {
        Form {
            
            Section {
                Picker("Practice Table", selection: $timesTable) {
                    ForEach(2..<13, id:\.self) {
                        Text("\($0)")
                    }
                }
                Picker("Number of questions", selection: $numberOfQuestions) {
                    ForEach(numberOfQuestionsOptions, id:\.self) {
                        Text("\($0)")
                    }
                }
            } header : {
                Text("Game settings")
            }
            
            Section {
                Button("Start!") {
                    onStartClick(timesTable, numberOfQuestions)
                }
            }
            
        }.navigationTitle("Start Game")

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        StartGameView(onStartClick: { _, _ in })
    }
}
