//
//  FileManager-Documents.swift
//  Bucketlist
//
//  Created by nfls on 05/08/2023.
//

import Foundation

extension FileManager {
    
    // Wraps path selection
    static func getPathFor(appDirectory: SearchPathDirectory) -> URL {
        let paths = FileManager.default.urls(for: appDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    // Decodes file into generic entity
    static func decode<T: Decodable>(_ file: URL) -> T? {
        
        guard let fileData = FileManager.default.contents(atPath: file.path) else {
            return nil
        }
        
        let decoder = JSONDecoder()
        // Should change based on data format
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        guard let loaded = try? decoder.decode(T.self, from: fileData) else {
            return nil
        }
        
        return loaded
    }
    
    static func encode<T: Encodable>(_ data: [T], path: URL, options: Data.WritingOptions) {
        do {
            let data = try JSONEncoder().encode(data)
            try data.write(to: path, options: options)
        } catch {
            print("Unable to save data.")
        }
    }
    
    // Writes a single string to file
    static func writeStringToFile(_ data: String, file: URL) {
        do {
            try data.write(to: file, atomically: true, encoding: .utf8)
        } catch {
            print("Oops! \(error.localizedDescription)")
        }
    }
    
    // Reads a string from file
    static func readStringFromFile(file: URL) -> String? {
        do {
            let input = try String(contentsOf: file)
            return input
        } catch {
            print("Oops! \(error.localizedDescription)")
            return nil
        }
    }
}
