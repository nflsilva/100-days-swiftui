//
//  PhotoPicker.swift
//  iPeopleChallenge
//
//  Created by nfls on 10/08/2023.
//

import PhotosUI
import SwiftUI

struct ImagePickerView: UIViewControllerRepresentable {
    
    // Contains returning image
    @Binding var image: UIImage?
    
    // Handles PHPickerViewController response
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        
        var parent: ImagePickerView
        
        init(_ parent: ImagePickerView) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            
            guard let provider = results.first?.itemProvider else { return }
            
            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { image, _ in
                    self.parent.image = image as? UIImage
                }
            }
        }
    }
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        
        // Selecting images for now
        config.filter = .images
        
        let picker = PHPickerViewController(configuration: config)

        // Make sure the result is handled by our coordinator
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        // Empty for now
    }
    
    func makeCoordinator() -> Coordinator {
        // Called by PHPickerViewController
        Coordinator(self)
    }
    
}
