//
//  MainGameView.swift
//  iTimesTables
//
//  Created by nfls on 27/05/2023.
//

import SwiftUI

enum ScreenState {
    case mainMenu
    case startGame
    case game
    case gameOver
}

struct MainGameView: View {
    
    @State private var screenState: ScreenState = .mainMenu
    @State private var timesTable = 1
    @State private var numberOfQuestions = 1
    
    var body: some View {
        
        NavigationView {
            
            switch(screenState) {
            case .mainMenu: MainMenuView(onStartClick: {
                
                changeStateTo(.startGame)
            })
            case .startGame: StartGameView(onStartClick: { timesTable, numberOfQuestions in
                self.timesTable = timesTable
                self.numberOfQuestions = numberOfQuestions
                
                changeStateTo(.game)
            })
            case .game: GamePlayView(numberOfQuestions: numberOfQuestions,
                                     timesTable: timesTable) {
                
                changeStateTo(.gameOver)
            }
            case .gameOver: GameOverView(onBackClick: {
                
                changeStateTo(.startGame)
            })
            }
        }
          
    }
    
    func changeStateTo(_ newState: ScreenState) {
        withAnimation {
            screenState = newState
        }
    }
    
}

struct MainGameView_Previews: PreviewProvider {
    static var previews: some View {
        MainGameView()
    }
}
