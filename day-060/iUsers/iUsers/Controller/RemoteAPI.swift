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
    
    static func GetUsers(completion: @escaping ([UserDTO], Error?) -> Void) {
        
        let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
        
        let task = URLSession.shared.dataTask(with: url) { data, _, requestError in
            
            if let requestError = requestError {
                completion([], requestError)
                return
            }
            
            guard let data = data else {
                completion([], APIError.NoDataError)
                return
            }
            
            do {
                let users = try JSONDecoder().decode([UserDTO].self, from: data)
                completion(users, nil)
            } catch {
                completion([], error)
            }
        }
        task.resume()
    }
    
}
