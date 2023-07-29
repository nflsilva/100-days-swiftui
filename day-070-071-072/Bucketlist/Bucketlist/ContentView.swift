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
    
    @State private var mapRegion =
    MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 50, longitude: 0),
        span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
    
    var body: some View {
        
        ZStack {
            
            Map(coordinateRegion: $mapRegion, annotationItems: locations) { location in
                MapMarker(coordinate:CLLocationCoordinate2D(latitude: location.latitute,
                                                            longitude: location.longitude))
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
