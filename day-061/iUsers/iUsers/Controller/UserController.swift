//
//  UserController.swift
//  iUsers
//
//  Created by nfls on 29/06/2023.
//

import Foundation
import SwiftUI

struct UserController {
    
    @Environment(\.managedObjectContext) private var moc
    @FetchRequest(sortDescriptors: []) private var users: FetchedResults<CDUser>

    func GetUsers(completion: @escaping ([UserDTO], Error?) -> Void) {
        
        RemoteAPI.GetUsers() { data, error in
            
            if error == nil {
                    
                for user in data {
                    
                    let cdUser = CDUser(context: moc)
                    cdUser.id = user.id
                    cdUser.name = user.name
                    cdUser.isActive = user.isActive
                    cdUser.age = Int16(user.age)
                    cdUser.company = user.company
                    cdUser.email = user.email
                    cdUser.address = user.address
                    cdUser.about = user.about
                    cdUser.tags = ""
                    for i in user.tags.indices {
                        cdUser.tags! += user.tags[i]
                        if i != user.tags.count - 1 {
                            cdUser.tags! += ","
                        }
                    }
                    /*
                    cdUser.friends = []
                    for f in user.friends {
                        let friend = CDFriend(context: moc)
                        friend.id = f.id
                        friend.name = f.name
                        cdUser.friends!.adding(friend)
                    }*/
                    
                    do {
                        try moc.save()
                    } catch {
                        print(error.localizedDescription)
                    }
                }
                
                completion(data, nil)

            }
            else {
                var result = [UserDTO]()
                for user in users {
                    var tags = [String]()
                    let preTags = user.tags?.split(separator: ",") ?? []
                    for t in preTags {
                        tags.append(String(t))
                    }
                    
                    var friends = [FriendDTO]()
                    /*
                    for f in user.friends ?? NSSet() {
                        let ff = f as! CDFriend
                        friends.append(FriendDTO(id: ff.id ?? UUID(),
                                                 name: ff.name ?? ""))
                    }*/
                    
                    result.append(UserDTO(id: user.id ?? UUID(),
                                          isActive: user.isActive,
                                          name: user.name ?? "",
                                          age: Int(user.age),
                                          company: user.company ?? "",
                                          email: user.email ?? "",
                                          address: user.address ?? "",
                                          about: user.about ?? "",
                                          tags: tags,
                                          friends: friends))
                }
                completion(result, nil)
            }
        }
    }
    
}
