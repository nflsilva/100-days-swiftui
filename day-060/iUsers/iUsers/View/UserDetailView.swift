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
    
    private let gridItemLayout = [
        GridItem(.flexible(), spacing: 1),
        GridItem(.flexible(), spacing: 1),
        GridItem(.flexible(), spacing: 1)
    ]
    
    var body: some View {
        
        ScrollView {
            
            LazyVStack {
                
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
                .padding(.horizontal)
                
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

                    HStack {
                        Text(user.address)
                        Spacer()
                    }
                    
                    HStack(alignment: .top) {
                        Group {
                            Text("Tagged by ")
                                .foregroundColor(.primary.opacity(0.25)) +
                            
                            Text(user.randomTags) +
                            
                            Text(user.tags.count - 3 <= 0 ? "" : " + ")
                                .foregroundColor(.primary.opacity(0.25)) +
                            
                            Text(user.tags.count - 3 <= 0 ? "" : "\(user.tags.count - 3) more")
                        }

                        Spacer()
                    }
                    
                    ScrollView(.horizontal) {
                        LazyHStack {
                            ForEach(user.friends) { friend in
                                VStack {
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
                                                .stroke(.black, lineWidth: 2)
                                                .opacity(0.35)
                                        }
                                    Text(friend.name)
                                }

                            }
                        }
                    }
                    .padding(.vertical)
                    
                }
                .padding()
                
                HStack  {
                    Spacer()
                    Button {
                        
                    } label : {
                        Image(systemName: "square.grid.2x2")
                    }
                    Spacer()
                    Button {
                        
                    } label: {
                        Image(systemName: "person.crop.circle")
                    }
                    Spacer()
                }
                .font(.largeTitle)
                .foregroundColor(.primary.opacity(0.75))
                
                LazyVGrid(columns: gridItemLayout, spacing: 1) {
                    ForEach(0..<90, id: \.self) { _ in
                         Image("default-avatar")
                            .resizable()
                            .scaledToFill()
                            .overlay {
                                Color.black.opacity(0.25)
                            }
                    }
                }
                
            }
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
                                     tags: ["tag1", "tag2", "tag3", "tag4"],
                                     friends: [FriendDTO(id: UUID(), name: "Jane Doe")]))
    }
}
