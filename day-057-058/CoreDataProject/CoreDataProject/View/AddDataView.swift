//
//  AddDataView.swift
//  CoreDataProject
//
//  Created by nfls on 24/06/2023.
//

import SwiftUI

struct AddDataView: View {

    @Environment(\.managedObjectContext) private var moc
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack {
            Button {
                addData()
            } label: {
                Text("Add")
            }
            
            Button {
                dismiss()
            } label: {
                Text("Dismiss")
            }
        }
    }
    
    private func addData() {
        addArtistData(name: "Breaking Benjamin",
                      picture: "bb",
                      tracks: ["Diary of Jane", "So Cold", "Firefly", "Devil"])
        
        addArtistData(name: "Linkin Park",
                      picture: "lp",
                      tracks: ["Papercut", "In the End", "Faint", "One step closer"])
        
        addArtistData(name: "Guano Apes",
                      picture: "ga",
                      tracks: ["Big in Japan", "Lord of the Boats", "High", "Rain"])
        
        addArtistData(name: "Delain",
                      picture: "dl",
                      tracks: ["One Second", "Sing to Me", "Chemical Redemption", "Let's Dance"])
        
    }
    
    private func addArtistData(name: String, picture: String, tracks: [String]) {
        let a = Artist(context: moc)
        a.id = UUID()
        a.name = name
        a.picture = picture
        
        for track in tracks {
            let t = Track(context: moc)
            t.id = UUID()
            t.name = track
            t.duration = [123, 542, 212, 412].randomElement() ?? 341
            t.artist = a
        }

        if moc.hasChanges {
            do {
                try moc.save()
            } catch {
                print(error.localizedDescription)
            }
            
        }
    }
    
}

struct AddDataView_Previews: PreviewProvider {
    static var previews: some View {
        AddDataView()
    }
}
