//
//  ContentView.swift
//  WordScramble
//
//  Created by nfls on 20/05/2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var words = [String]()
    @State private var newWord = ""
    @State private var rootWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("Please enter a new word here", text: $newWord)
                        .autocapitalization(.none)
                }
                
                Section {
                    ForEach(words, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle.fill")
                            Text(word)
                        }
                    }
                }
            }
            .navigationTitle(rootWord)
            .onSubmit(addNewWord)
            .onAppear(perform: loadData)
            .alert(errorTitle, isPresented: $showingError) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(errorMessage)
            }
        }
        
    }
    
    private func addNewWord() {
        let escapedWord = newWord
            .lowercased()
            .trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard escapedWord.count > 0 else { return }
        
        guard isInUse(word: escapedWord) else {
            displayErrorWith(title: "Word used already", message: "Be more original!")
            return
        }
        
        guard isPossible(word: escapedWord) else {
            displayErrorWith(title: "Word not possbile", message: "You can't spell that word from \(rootWord)!")
            return
        }
        
        guard isReal(word: escapedWord) else {
            displayErrorWith(title: "Word not recognized", message: "You can't make words up")
            return
        }
        
        withAnimation {
            words.insert(escapedWord, at: 0)
        }
        
        newWord = ""
    }
    
    private func loadData() {
        guard let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt"),
              let startWords = try? String(contentsOf: startWordsURL) else {
                  fatalError("Could not load start.txt from bundle. Should not happend.")
              }
        
        let allWords = startWords.components(separatedBy: "\n")
        rootWord = allWords.randomElement() ?? "silkworm"
    }
    
    private func isInUse(word: String) -> Bool {
        return !words.contains(word)
    }
    
    private func isPossible(word: String) -> Bool {
        var rootWordChars = rootWord
        for letter in word {
            
            if let pos = rootWordChars.firstIndex(of: letter) {
                rootWordChars.remove(at: pos)
            }
            else {
                return false
            }
            
        }
        return true
    }
    
    private func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(
            in: word,
            range: range,
            startingAt: 0,
            wrap: false,
            language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    private func displayErrorWith(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
    
}
    
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
