//
//  ContentView.swift
//  Instafilter
//
//  Created by nfls on 25/07/2023.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import PhotosUI
import SwiftUI

struct ContentView: View {
    
    @State private var inputUIImage: UIImage?
    @State private var image: Image?
    @State private var showingImagePicker = false
    @State private var showingFilterSelection = false
    @State private var intensity = 0.5
    
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    private let ciContext = CIContext()
    
    var body: some View {
        NavigationView {
            VStack {
                
                ZStack(alignment: .center) {
                    
                    if image == nil {
                        Text("Tap to select a picture")
                            .foregroundColor(.white)
                    }
                    else {
                        image?
                            .resizable()
                            .scaledToFit()
                    }
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(image == nil ? .gray : .clear)
                .padding(.bottom)
                .onTapGesture(perform: onSelectPictureTap)
                
                HStack {
                    Text("Intensity")
                    Slider(value: $intensity)
                        .onChange(of: intensity) { _ in onIntensityChange() }
                }
                .padding(.bottom)
                
                HStack {
                    Button("Change Filter", action: changeFilter)
                    Spacer()
                    Button("Save", action: save)
                }
                
            }
            .padding()
            .navigationTitle("Instafilter")
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $inputUIImage)
        }
        .confirmationDialog("Filter", isPresented: $showingFilterSelection) {
            Button("Crystallize") { setFilter(CIFilter.crystallize()) }
            Button("Edges") { setFilter(CIFilter.edges()) }
            Button("Gaussian Blur") { setFilter(CIFilter.gaussianBlur()) }
            Button("Pixellate") { setFilter(CIFilter.pixellate()) }
            Button("Sepia Tone") { setFilter(CIFilter.sepiaTone()) }
            Button("Unsharp Mask") { setFilter(CIFilter.unsharpMask()) }
            Button("Vignette") { setFilter(CIFilter.vignette()) }
            Button("Cancel", role: .cancel) { }
        }
        .onChange(of: inputUIImage) { _ in loadImage() }
        
    }
    
    private func loadImage() {
        guard let inputImage = inputUIImage else { return }
        
        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        onIntensityChange()
    }
    
    private func onSelectPictureTap() {
        self.showingImagePicker = true
    }
    
    private func onIntensityChange() {
        let inputKeys = currentFilter.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(intensity, forKey: kCIInputIntensityKey)
        }
        
        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(intensity * 200, forKey: kCIInputRadiusKey)
        }
        
        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(intensity * 10, forKey: kCIInputScaleKey)
        }
        
        guard let outputImage = currentFilter.outputImage else { return }
        
        if let cgimg = ciContext.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
        }
    }
    
    private func changeFilter() {
        showingFilterSelection = true
    }
    
    private func save() {
        
    }
    
    private func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
