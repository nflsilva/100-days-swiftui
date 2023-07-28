//
//  FileManager+Decode.swift
//  CodableDocuments
//
//  Created by nfls on 28/07/2023.
//

import Foundation

extension FileManager {
    
    func getPathFor(appDirectory: SearchPathDirectory) -> URL {
        let paths = self.urls(for: appDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func decode<T: Decodable>(_ file: String) -> T? {
        
        guard let fileData = self.contents(atPath: file) else {
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
    
    func writeStringToFile(_ data: String, file: URL) {
        do {
            try data.write(to: file, atomically: true, encoding: .utf8)
        } catch {
            print("Oops! \(error.localizedDescription)")
        }
    }
    
    func readStringFromFile(file: URL) -> String? {
        do {
            let input = try String(contentsOf: file)
            return input
        } catch {
            print("Oops! \(error.localizedDescription)")
            return nil
        }
    }
    
}
