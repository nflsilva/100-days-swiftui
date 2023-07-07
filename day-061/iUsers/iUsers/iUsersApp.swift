//
//  iUsersApp.swift
//  iUsers
//
//  Created by nfls on 29/06/2023.
//

import SwiftUI

@main
struct iUsersApp: App {
    @StateObject private var dataController = DataModelController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
