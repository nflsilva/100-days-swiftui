//
//  BookDetailView.swift
//  Bookworm
//
//  Created by nfls on 20/06/2023.
//

import SwiftUI

struct BookDetailView: View {
    
    @Environment(\.managedObjectContext) private var moc
    @Environment(\.dismiss) private var dismiss
    @State private var showingDeleteAlert = false
    
    let book: Book
    
    var body: some View {
        ScrollView {
            VStack {
                GenreImageView(genre: book.genre ?? AddBookView.genres[0])
                Text(book.author ?? "Unknown Author")
                    .font(.title)
                    .foregroundColor(.primary.opacity(0.75))
                
                VStack {
                    Text(book.review ?? "No review yet.")
                        .font(.body)
                    
                    RatingView(rating: .constant(Int16(book.rating)))
                        .font(.largeTitle)
                        .padding(.top)
                }
                .padding()
            }
        }
        .navigationTitle(book.title ?? "Unknown Title")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Delete book?", isPresented: $showingDeleteAlert) {
            Button("Delete", role: .destructive, action: deleteBook)
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Are you sure?")
        }
        .toolbar {
            Button {
                showingDeleteAlert = true
            } label: {
                Label("Delete this book", systemImage: "trash")
            }
        }
    }
    
    private func deleteBook() {
        moc.delete(book)
        
        //try? moc.save()
        
        dismiss()
    }
}

struct BookDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BookDetailView(book: Book(context: DataController().container.viewContext))
            .preferredColorScheme(.dark)
    }
}
