//
//  Order.swift
//  CupcakeCorner
//
//  Created by nfls on 14/06/2023.
//

import Foundation

struct Order: Codable {
    
    static let cupcakeTypes = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    enum CodingKeys: CodingKey {
        case cupcakeTypeIndex, numberOfCakes, hasSpecialRequest, hasSpecialFrosting, hasExtraSprinkles, name, streetName, city, zipcode
    }
    
    var cupcakeTypeIndex = 0
    var numberOfCakes = 1
    var hasSpecialRequest = false {
        didSet {
            if hasSpecialRequest == false {
                hasSpecialFrosting = false
                hasExtraSprinkles = false
            }
        }
    }
    var hasSpecialFrosting = false
    var hasExtraSprinkles = false
    
    var name = ""
    var streetName = ""
    var city = ""
    var zipcode = ""
    
    private func fieldIsInvalid(_ data: String) -> Bool {
        return data.isEmpty || data == " "
    }
    
    var hasInvalidAddress: Bool {
        return fieldIsInvalid(name) || fieldIsInvalid(streetName) || fieldIsInvalid(city) || fieldIsInvalid(zipcode)
    }
    var cost: Double {
        
        var cost = Double(numberOfCakes) * 2
        
        cost += (Double(cupcakeTypeIndex) / 2)
        
        if hasSpecialFrosting {
            cost += Double(numberOfCakes)
        }
        
        if hasExtraSprinkles {
            cost += Double(numberOfCakes) / 2
        }
        
        return cost
    }

}
