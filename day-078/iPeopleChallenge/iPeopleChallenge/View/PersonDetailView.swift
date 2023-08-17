//
//  PersonDetailView.swift
//  iPeopleChallenge
//
//  Created by nfls on 11/08/2023.
//

import MapKit
import SwiftUI

struct PersonDetailView: View {
    
    @State var person: Person
    @State private var image: Image?
    
    init(person: Person) {
        _person = State(initialValue: person)
    }
    
    var body: some View {
        
        VStack {
            ZStack(alignment: .center) {
                image?
                    .resizable()
                    .scaledToFit()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.bottom)
            
            Map(coordinateRegion: Binding.constant(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: person.latitude,
                                                                                                     longitude: person.longitude),
                                                                      span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))))
            
        }
        .navigationTitle(person.name)
        .onAppear {
            loadImage()
        }

        
    }
    
    private func loadImage() {
        if let uiImage = UIImage(contentsOfFile: person.picturePath) {
            image = Image(uiImage: uiImage)
        }
    }
    
}

struct PersonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PersonDetailView(person: Person(name: "Nelson",
                                        picturePath: "",
                                        latitude: 0.0,
                                        longitude: 0.0))
    }
}
