//
//  ContentView.swift
//  iUsers
//
//  Created by nfls on 29/06/2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isLoading = false
    @State private var users = [UserDTO]()
    
    @State private var isShowingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    private let usersController = UserController()
    
    var body: some View {
        NavigationView {
            
            if(isLoading) {
                LoadingView()
            }
            else {
                List(users) { user in
                    NavigationLink(user.name) {
                        UserDetailView(user: user)
                    }
                }
            }
        }
        .task {
            loadData()
        }
        .alert(alertTitle, isPresented: $isShowingAlert) {
            Button("OK") { }
        } message: {
            Text(alertMessage)
        }
        .navigationTitle("iUsers")
    }
    
    private func loadData() {
        if(isLoading || !users.isEmpty){ return }
        
        isLoading = true
        
        usersController.GetUsers() { users, error in
            
            if let error = error {
                isLoading = false
                alertTitle = "Error loading data"
                alertMessage = error.localizedDescription
                isShowingAlert = true
                return
            }
            
            self.users = users
            isLoading = false
        }
        
            
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
