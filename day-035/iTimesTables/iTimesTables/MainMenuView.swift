//
//  MainMenuView.swift
//  iTimesTables
//
//  Created by nfls on 27/05/2023.
//

import SwiftUI

struct MainMenuView: View {
    
    let onStartClick: () -> ()
    
    var body: some View {
        VStack {
            Text("Main Menu!")
            Button("Start game") {
                onStartClick()
            }
        }.navigationTitle("Main menu")
    }
}

struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView(onStartClick: {})
    }
}
