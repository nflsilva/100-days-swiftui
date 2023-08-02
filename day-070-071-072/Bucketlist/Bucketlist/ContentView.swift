//
//  ContentView.swift
//  Bucketlist
//
//  Created by nfls on 28/07/2023.
//

import MapKit
import SwiftUI

struct ContentView: View {
    
    @State private var locations = [Location]()
    
    @State private var mapRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 50, longitude: 0),
        span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
    
    @State private var selectedLocation: Location?
    
    var body: some View {
        
        ZStack {
            
            Map(coordinateRegion: $mapRegion, annotationItems: locations) { location in
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
                        selectedLocation = location
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
                        addNewLocation()
                    } label: {
                        Image(systemName: "plus")
                    }
                    .padding()
                    .background(.black.opacity(0.75))
                    .foregroundColor(.white)
                    .clipShape(Circle())
                    .padding(.trailing)
                }
            }
            .sheet(item: $selectedLocation) { location in
                EditView(location: location) { newLocation in
                    if let index = locations.firstIndex(of: location) {
                        locations[index] = newLocation
                    }
                }
            }
            
        }
        
    }
    
    private func addNewLocation() {
        
        let newLocation = Location(id: UUID(),
                                   name: "New location",
                                   description: "",
                                   latitute: mapRegion.center.latitude,
                                   longitude: mapRegion.center.longitude)
        locations.append(newLocation)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
