//
//  Bundle+Decodable.swift
//  Moonshot
//
//  Created by nfls on 03/06/2023.
//

import Foundation

extension Bundle {
    
    func decode<T: Decodable>(_ file: String) -> T {
        
        guard let fileUrl = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate file \(file) in bundle.")
        }
        
        guard let fileData = try? Data(contentsOf: fileUrl) else {
            fatalError("Failed to load file \(file) from bundle.")
        }
        
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        guard let loaded = try? decoder.decode(T.self, from: fileData) else {
            fatalError("Failed to decode file \(file) from bundle.")
        }
        
        return loaded
    }
    
    
}
