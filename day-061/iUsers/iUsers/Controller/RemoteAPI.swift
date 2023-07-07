//
//  RemoteAPI.swift
//  iUsers
//
//  Created by nfls on 29/06/2023.
//

import Foundation

struct RemoteAPI {
    
    enum APIError: String, Error {
        case NoDataError = "API returned no error."
        case InvalidDataError = "API returned invalid data."
    }
    
    static func GetUsers() async -> [UserDTO]? {
        
        let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let users = try JSONDecoder().decode([UserDTO].self, from: data)
            sleep(4) // simulate slow connection
            return users
            
        } catch {
            return nil
        }


    }
    
}
