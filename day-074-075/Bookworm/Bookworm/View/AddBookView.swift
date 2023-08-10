//
//  AddBookView.swift
//  Bookworm
//
//  Created by nfls on 20/06/2023.
//

import SwiftUI

struct AddBookView: View {
    
    static let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    @Environment(\.managedObjectContext) private var moc
    @Environment(\.dismiss) private var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private var genre = ""
    @State private var review = ""
    @State private var rating = Int16(0)
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Title", text: $title)
                    TextField("Author", text: $author)
                    Picker("Genre", selection: $genre) {
                        ForEach(AddBookView.genres, id:\.self) {
                            Text($0)
                        }
                    }
                }
                
                Section {
                    TextEditor(text: $review)
                    RatingView(rating: $rating)
                } header: {
                    Text("Write a review")
                }
                
                Section {
                    Button {
                        let book = Book(context: moc)
                        book.id = UUID()
                        book.title = title
                        book.author = author
                        book.genre = genre
                        book.review = review
                        book.rating = rating
                        book.date = Date.now
                        try? moc.save()
                        dismiss()
                    } label: {
                        Text("Save")
                    }
                    .disabled(!formIsValid())
                }
                
            }
            .navigationTitle("Add Book")
        }
    }

    private func formIsValid() -> Bool {
        return title.count > 0
        && author.count > 0
        && genre.count > 0
        && review.count > 0
    }
    
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
