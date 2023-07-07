//
//  LoadingView.swift
//  iUsers
//
//  Created by nfls on 29/06/2023.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            Text("Loading data...")
                .padding(.vertical)
            ProgressView()
                .font(.largeTitle)
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
