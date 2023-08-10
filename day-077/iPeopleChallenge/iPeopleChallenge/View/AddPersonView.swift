//
//  AddPerson.swift
//  iPeopleChallenge
//
//  Created by nfls on 10/08/2023.
//

import SwiftUI

struct AddPersonView: View {
    
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = ViewModel()
    var onSave: (String, UIImage) -> ()
    
    var body: some View {
        
        VStack {
            ZStack(alignment: .center) {
                if viewModel.image == nil {
                    Text("Tap to select a picture")
                        .foregroundColor(.white)
                }
                else {
                    viewModel.image?
                        .resizable()
                        .scaledToFit()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(viewModel.image == nil ? .gray : .clear)
            .padding(.bottom)
            .onTapGesture {
                viewModel.showingPicker = true
            }
            .sheet(isPresented: $viewModel.showingPicker) {
                ImagePickerView(image: $viewModel.uiImage)
                    .onChange(of: viewModel.uiImage) { _ in
                        viewModel.loadImage()
                    }
            }
            
            Form {
                Section {
                    TextField("Name", text: $viewModel.name)
                }
                Button("Save") {
                    guard let uiImage = viewModel.uiImage else { return }
                    onSave(viewModel.name, uiImage)
                    dismiss()
                }
            }
            .navigationTitle("Add new Person")
        }

    }
}

struct AddPerson_Previews: PreviewProvider {
    static var previews: some View {
        AddPersonView(onSave: { name, picture in
            
        })
    }
}
