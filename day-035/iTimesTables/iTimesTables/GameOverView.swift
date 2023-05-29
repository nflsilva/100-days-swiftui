//
//  GameOverView.swift
//  iTimesTables
//
//  Created by nfls on 27/05/2023.
//

import SwiftUI

struct GameOverView: View {
    
    let onBackClick: () -> ()
    
    var body: some View {
        VStack {
            Text("Game Over!")
            Button("Back to main view") {
                onBackClick()
            }
        }
    }
}

struct GameOverView_Previews: PreviewProvider {
    static var previews: some View {
        GameOverView(onBackClick: {})
    }
}
