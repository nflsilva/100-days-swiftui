//
//  ContentView-ViewModel.swift
//  Bucketlist
//
//  Created by nfls on 05/08/2023.
//

import Foundation
import LocalAuthentication
import MapKit

extension ContentView {
    
    @MainActor class ViewModel: ObservableObject {
        @Published var selectedLocation: Location?
        @Published private(set) var locations: [Location]
        @Published var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 50, longitude: 0),
                                                      span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
        @Published private(set) var isAuthenticated = false
        
        private let savePath = FileManager.getPathFor(appDirectory: .documentDirectory).appendingPathComponent("savedPlaces")
        
        init() {
            locations = FileManager.decode(savePath) ?? []
        }
        
        func addNewLocation() {
            let newLocation = Location(id: UUID(),
                                       name: "New location",
                                       description: "",
                                       latitute: mapRegion.center.latitude,
                                       longitude: mapRegion.center.longitude)
            locations.append(newLocation)
            save()
        }
        
        func update(location: Location) {
            guard let selectedLocation = selectedLocation else { return }
            
            if let index = locations.firstIndex(of: selectedLocation) {
                locations[index] = location
                save()
            }
        }
        
        func save() {
            FileManager.encode(locations, path: savePath, options: [.atomicWrite, .completeFileProtection])
        }
        
        func authenticate() {
            let context = LAContext()
            var error: NSError?

            // check whether biometric authentication is possible
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                // it's possible, so go ahead and use it
                let reason = "We need to unlock your data."

                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                    // authentication has now completed
                    if success {
                        Task { @MainActor in
                            self.isAuthenticated = true
                        }
                    } else {
                        // there was a problem
                    }
                }
            } else {
                // no biometrics
            }
        }
        
    }
    
}
