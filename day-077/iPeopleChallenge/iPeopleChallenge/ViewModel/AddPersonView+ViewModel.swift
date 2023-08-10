//
//  AddPersonView+ViewModel.swift
//  iPeopleChallenge
//
//  Created by nfls on 10/08/2023.
//

import Foundation
import UIKit
import SwiftUI

extension AddPersonView {
    
    @MainActor class ViewModel: ObservableObject {
        @Published var name = ""
        @Published var picture = ""
        @Published var showingPicker = false
        @Published var image: Image? = nil
        @Published var uiImage: UIImage? = nil
        
        func loadImage() {
            guard let inputImage = uiImage else { return }
            image = Image(uiImage: inputImage)
        }
        
    }
    
}
