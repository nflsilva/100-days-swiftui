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
        .padding(10)
        .background(.white)
        .clipShape(Capsule())


    }
}

struct ContentView: View {
    
    var body: some View {
        ZStack {
            Color.secondary
            
            VStack {
                Text("Play to")
                Text("WIN!")
                
                HStack {
                    HandSelectionImage(image: "rock")
                }
                
                HStack {
                    HandSelectionImage(image: "rock")
                    HandSelectionImage(image: "paper")
                    HandSelectionImage(image: "scissors")
                }
                
            }
            

            
            
            
            
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
