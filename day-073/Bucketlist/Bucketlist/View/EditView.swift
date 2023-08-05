//
//  EditView.swift
//  Bucketlist
//
//  Created by nfls on 02/08/2023.
//

import SwiftUI
import MapKit

struct Result: Codable {
    let query: Query
}

struct Query: Codable {
    let pages: [Int: Page]
}

struct Page: Codable, Comparable {
    static func < (lhs: Page, rhs: Page) -> Bool {
        lhs.title < rhs.title
    }
    
    var description: String {
        terms?["description"]?.first ?? "No information available."
    }
    
    let pageid: Int
    let title: String
    let terms: [String: [String]]?
    
}

enum LoadingState {
    case loading, loaded, failed
}

struct EditView: View {
    
    @Environment(\.dismiss) private var dismiss
    private let onSave: (Location) -> ()
    
    @StateObject var viewModel: ViewModel
    
    init(location: Location, onSave: @escaping (Location) -> Void) {
        _viewModel = StateObject(wrappedValue: ViewModel(location: location))
        self.onSave = onSave
    }
    
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $viewModel.name)
                TextField("Description", text: $viewModel.description)
                
                Section("Nearby…") {
                    switch viewModel.loadingState {
                    case .loaded:
                        ForEach(viewModel.pages, id: \.pageid) { page in
                            Text(page.title)
                                .font(.headline)
                            + Text(": ") +
                            Text(page.description)
                                .italic()
                        }
                    case .loading:
                        Text("Loading…")
                    case .failed:
                        Text("Please try again later.")
                    }
                }
                
            }
            .toolbar {
                Button("Save") {
                    var newLocation = viewModel.location
                    newLocation.id = UUID()
                    newLocation.name = viewModel.name
                    newLocation.description = viewModel.description
                    
                    onSave(newLocation)
                    dismiss()
                }
            }
            .navigationTitle("Place details")
            .task {
                await fetchNearbyPlaces()
            }

        }

    }

    
    func fetchNearbyPlaces() async {
        let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(viewModel.location.coordinates.latitude)%7C\(viewModel.location.coordinates.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"

        guard let url = URL(string: urlString) else {
            print("Bad URL: \(urlString)")
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)

            // we got some data back!
            let items = try JSONDecoder().decode(Result.self, from: data)

            // success – convert the array values to our pages array
            
            Task { @MainActor in
                viewModel.pages = items.query.pages.values.sorted { $0.title < $1.title }
                viewModel.loadingState = .loaded
            }

        } catch {
            viewModel.loadingState = .failed
        }
    }
    
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(location: Location.example, onSave: { _ in })
    }
}
