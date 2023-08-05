//
//  ContentView.swift
//  Bucketlist
//
//  Created by nfls on 28/07/2023.
//

import MapKit
import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        if viewModel.isAuthenticated {
            ZStack {
                
                Map(coordinateRegion: $viewModel.mapRegion, annotationItems: viewModel.locations) { location in
                    MapAnnotation(coordinate: location.coordinates) {
                        VStack {
                            Image(systemName: "star.circle")
                                .resizable()
                                .foregroundColor(.red)
                                .frame(width: 44, height: 44)
                                .background(.white)
                                .clipShape(Circle())
                            Text(location.name)
                                .fixedSize()
                        }
                        .onTapGesture {
                            viewModel.selectedLocation = location
                        }
                    }
                }
                .ignoresSafeArea()
                
                Circle()
                    .fill(.blue)
                    .opacity(0.3)
                    .frame(width: 32, height: 32)
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button {
                            viewModel.addNewLocation()
                        } label: {
                            Image(systemName: "plus")
                                .padding()
                                .background(.black.opacity(0.75))
                                .foregroundColor(.white)
                                .clipShape(Circle())
                                .padding(.trailing)
                        }

                    }
                }
                .sheet(item: $viewModel.selectedLocation) { location in
                    EditView(location: location) { newLocation in
                        viewModel.update(location: newLocation)
                    }
                }
                
            }
        }
        else {
            Button("Authenticate") {
                viewModel.authenticate(onCompletion: { result, message in
                    if !result, let message = message {
                        Task { @MainActor in
                            viewModel.isShowingAlert = true
                            viewModel.alertText = message
                        }
                    }
                })
            }
            .padding()
            .background(.blue)
            .foregroundColor(.white)
            .clipShape(Capsule())
            .alert("Error", isPresented: $viewModel.isShowingAlert) {
                Button("OK") { }
            } message: {
                Text(viewModel.alertText)
            }
        }
    }
    

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
