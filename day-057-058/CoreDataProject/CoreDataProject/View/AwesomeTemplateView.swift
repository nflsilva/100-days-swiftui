//
//  AwesomeTemplateView.swift
//  CoreDataProject
//
//  Created by nfls on 24/06/2023.
//

import CoreData
import SwiftUI

struct AwesomeTemplateView<T: NSManagedObject, Content: View>: View {
    
    @FetchRequest private var fetchRequest: FetchedResults<T>
    @ViewBuilder var content: (T) -> Content
    
    var body: some View {
        if fetchRequest.count == 0 {
            VStack {
                Image(systemName: "rectangle.and.text.magnifyingglass")
                    .font(.largeTitle)
                    .padding(.vertical)
                    .foregroundColor(.primary.opacity(0.55))
                Text("No data")
                    .font(.title)
                    .foregroundColor(.primary.opacity(0.75))
            }
        }
        else {
            ScrollView {
                VStack(spacing: 10) {
                    ForEach(fetchRequest, id: \.self) { item in
                        self.content(item)
                    }
                }
            }
        }
    }
     
    init(filterKey: String, filterValue: String, content: @escaping (T) -> Content) {
        
        var predicate: NSPredicate? = nil
        if !filterValue.isEmpty {
            predicate = NSPredicate(format: "%K BEGINSWITH %@", filterKey, filterValue)
        }
        
        _fetchRequest = FetchRequest<T>(sortDescriptors: [],
                                        predicate: predicate,
                                        animation: Animation.easeInOut
        )
        self.content = content
    }
            
}

struct AwesomeTemplateView_Previews: PreviewProvider {
    static var previews: some View {
        AwesomeTemplateView(filterKey: "name", filterValue: "") { artist in
            Text("Hey!")
        }
        .preferredColorScheme(.dark)
    }
}
