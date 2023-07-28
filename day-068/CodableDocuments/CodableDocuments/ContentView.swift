//
//  ContentView.swift
//  CodableDocuments
//
//  Created by nfls on 28/07/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
            .onTapGesture {
                
                let data = "Hello world!"
                let url = FileManager.default.getPathFor(appDirectory: .documentDirectory).appendingPathComponent("text.txt")
                
                FileManager.default.writeStringToFile(data, file: url)
                
                if let readData = FileManager.default.readStringFromFile(file: url) {
                    print("Read data: \(readData)")
                }
                
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
