//
//  UserDetailView.swift
//  iUsers
//
//  Created by nfls on 29/06/2023.
//

import SwiftUI

struct UserStat: View {
    
    let number: String
    let name: String
    
    var body: some View {
        VStack {
            Text(number)
                .font(.headline)
            Text(name)
                .opacity(0.25)
        }
    }
    
}

struct UserDetailView: View {
    
    let user: UserDTO
    
    var body: some View {
        
        ScrollView {
            
            VStack {
                
                HStack {
                    
                    Image("default-avatar")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 75, height: 75)
                        .clipShape(Circle())
                        .overlay {
                            Circle()
                                .stroke(.black.opacity(0.35))
                        }
                        .padding(3)
                        .overlay {
                            Circle()
                                .stroke(user.isActive ? .green : .red, lineWidth: 2)
                                .opacity(0.35)
                        }
                    
                    Spacer()
                    
                    VStack {
                        HStack {
                            UserStat(number: String(user.friends.count), name: "friends")
                            Spacer()
                            UserStat(number: String(user.tags.count), name: "tags")
                            Spacer()
                            UserStat(number: String(user.age), name: "years old")
                        }
                        .padding(.top)

                        HStack {
                            Button {
                                
                            } label: {
                                Text("Edit Profile")
                                    .foregroundColor(.primary)
                                    .frame(maxWidth: .infinity)
                                    .padding(5)
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(.primary)
                                    }
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                
                VStack {
                    
                    HStack {
                        Text(user.name)
                            .font(.headline)
                        Spacer()
                    }
                    
                    HStack {
                        Text(user.about)
                            .padding(.top, 1)
                        Spacer()
                    }

                    HStack(alignment: .top) {
                        Text("Followed by")
                            .opacity(0.35)
                        
                        Text(user.randomFollowers)
                        
                        Spacer()
                    }
                    .padding(.top, 1)
  
                }
                .padding(.top)
            
            }
            .padding(.horizontal)
            .navigationTitle(user.username)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                
                HStack {
                    
                    Button {
                        
                    } label : {
                        Image(systemName: "plus.app")
                    }
                    .foregroundColor(.primary)

                    Button {
                        
                    } label : {
                        Image(systemName: "line.3.horizontal")
                    }
                    .foregroundColor(.primary)
                    

                }
                
                
            }

        }
        

    }
}

struct UserDetailView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailView(user: UserDTO(id: UUID(),
                                     isActive: true,
                                     name: "John Doe",
                                     age: 42,
                                     company: "Some super cool company",
                                     email: "some-email@company.net",
                                     address: "5th Elm's Street, NES",
                                     about: "Consectetur mollit fugiat dolor ea esse reprehenderit enim laboris laboris. Eiusmod consectetur quis cillum tempor veniam deserunt do. Qui ea amet esse qui mollit non non dolor sint consequat ullamco cillum. Sunt aute elit qui elit.",
                                     tags: ["tag1", "tag2", "tag3"],
                                     friends: []))
    }
}
