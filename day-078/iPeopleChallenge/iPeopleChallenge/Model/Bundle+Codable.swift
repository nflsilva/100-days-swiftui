//
//  Bundle+Decode.swift
//  iPeopleChallenge
//
//  Created by nfls on 10/08/2023.
//

import Foundation
extension FileManager {
    
    func getPathFor(appDirectory: SearchPathDirectory) -> URL {
        let paths = self.urls(for: appDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func decode<T: Decodable>(_ file: URL) -> T? {
        
        guard let fileData = self.contents(atPath: file.path) else {
            return nil
        }
        
        let decoder = JSONDecoder()
        
        guard let loaded = try? decoder.decode(T.self, from: fileData) else {
            return nil
        }
        
        return loaded
    }

    func encode<T: Encodable>(_ data: [T], path: URL, options: Data.WritingOptions) {
        do {
            let data = try JSONEncoder().encode(data)
            try data.write(to: path, options: options)
        } catch {
            print("Unable to save data.")
        }
    }
}
