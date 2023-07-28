//
//  DataModelController.swift
//  CoreDataProject
//
//  Created by nfls on 24/06/2023.
//

import CoreData
import Foundation

class DataModelController: ObservableObject {
    let container = NSPersistentContainer(name: "Newnamp")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("CoreData failed to load with error: \(error.localizedDescription)")
            }
        }
        
        container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
    }
}
