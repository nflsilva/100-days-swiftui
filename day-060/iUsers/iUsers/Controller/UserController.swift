//
//  UserController.swift
//  iUsers
//
//  Created by nfls on 29/06/2023.
//

import Foundation

struct UserController {
    
    func GetUsers(completion: @escaping ([UserDTO], Error?) -> Void) {
        
        RemoteAPI.GetUsers(completion: completion)
    }
    
}
