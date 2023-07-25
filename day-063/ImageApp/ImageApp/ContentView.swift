//
//  ContentView.swift
//  ImageApp
//
//  Created by nfls on 23/07/2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var image: Image?
    @State private var inputImage: UIImage?
    @State private var showingPicker = false
    
    var body: some View {
        VStack {
            
            image?
                .resizable()
                .scaledToFit()
            
            Button("Select an image") {
                showingPicker = true
            }
            
            Button("Save image") {
                guard let inputImage = inputImage else { return }
                
                let imageSaver = ImageSaver()
                imageSaver.writeToPhotoAlbum(image: inputImage)
            }
        }
        .sheet(isPresented: $showingPicker) {
            ImagePicker(image: $inputImage)
        }
        .onChange(of: inputImage) { _ in loadImage() }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
