//
//  EditView-ViewModel.swift
//  Bucketlist
//
//  Created by nfls on 05/08/2023.
//

import Foundation

extension EditView {
    
    @MainActor class ViewModel: ObservableObject {
        
        @Published var location: Location
        
        @Published var name: String
        @Published var description: String
        
        @Published var loadingState = LoadingState.loading
        @Published var pages = [Page]()
        
        init(location: Location) {
            self.location = location
            self.name = location.name
            self.description = location.description
        }
        
    }
    
}
