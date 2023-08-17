//
//  ContentView+ViewModel.swift
//  iPeopleChallenge
//
//  Created by nfls on 10/08/2023.
//

import UIKit
import Foundation

extension ContentView {
    
    @MainActor class ViewModel: ObservableObject {
        
        @Published private(set) var persons: [Person]
        @Published var selectedPersion: Person? = nil
        
        private let savePath = FileManager.default
            .getPathFor(appDirectory: .documentDirectory)
        
        init() {
            persons = FileManager.default.decode(savePath.appendingPathComponent("data.json")) ?? []
        }
        
        func addNewPerson(name: String, picture: UIImage) {
            
            if let jpegData = picture.jpegData(compressionQuality: 0.8) {
                let fileUrl = savePath.appendingPathComponent("\(UUID().uuidString).jpeg")
                try? jpegData.write(to: fileUrl, options: [.atomic])
                
                persons.append(Person(name: name, picturePath: fileUrl.path))
                FileManager.default.encode(persons, path: savePath.appendingPathComponent("data.json"), options: [.atomicWrite])
            }

        }
    }
    
}
