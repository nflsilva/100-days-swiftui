//
//  ContentView.swift
//  iPeopleChallenge
//
//  Created by nfls on 10/08/2023.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            
            VStack {
                
                List(viewModel.persons, id:\.self, selection: $viewModel.selectedPersion) { person in
                    NavigationLink {
                        PersonDetailView(person: person)
                    } label: {
                        Text(person.name)
                    }
                }
                
            }
            .toolbar {
                NavigationLink {
                    AddPersonView() { name, image, latitude, longitude in
                        viewModel.addNewPerson(name: name,
                                               picture: image,
                                               latitude: latitude,
                                               longitude: longitude)
                    }
                } label: {
                    Image(systemName: "plus")
                }
            }
            .navigationTitle("iPerson")

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
