//
//  DataController.swift
//  Bookworm
//
//  Created by nfls on 19/06/2023.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "Bookworm")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("CoreData failed to load with error: \(error.localizedDescription)")
            }
        }
    }
    
}
