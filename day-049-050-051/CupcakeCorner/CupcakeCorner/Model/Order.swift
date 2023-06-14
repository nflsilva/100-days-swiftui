//
//  Order.swift
//  CupcakeCorner
//
//  Created by nfls on 14/06/2023.
//

import Foundation

class Order: ObservableObject, Codable {
    
    static let cupcakeTypes = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    enum CodingKeys: CodingKey {
        case cupcakeTypeIndex, numberOfCakes, hasSpecialRequest, hasSpecialFrosting, hasExtraSprinkles, name, streetName, city, zipcode
    }
    
    @Published var cupcakeTypeIndex = 0
    @Published var numberOfCakes = 1
    @Published var hasSpecialRequest = false {
        didSet {
            if hasSpecialRequest == false {
                hasSpecialFrosting = false
                hasExtraSprinkles = false
            }
        }
    }
    @Published var hasSpecialFrosting = false
    @Published var hasExtraSprinkles = false
    
    @Published var name = ""
    @Published var streetName = ""
    @Published var city = ""
    @Published var zipcode = ""
    
    var hasInvalidAddress: Bool {
        return name.isEmpty || streetName.isEmpty || city.isEmpty || zipcode.isEmpty
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
    
    init() {}
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        cupcakeTypeIndex = try values.decode(Int.self, forKey: .cupcakeTypeIndex)
        numberOfCakes = try values.decode(Int.self, forKey: .numberOfCakes)
        hasSpecialRequest = try values.decode(Bool.self, forKey: .hasSpecialRequest)
        hasExtraSprinkles = try values.decode(Bool.self, forKey: .hasExtraSprinkles)
        name = try values.decode(String.self, forKey: .name)
        streetName = try values.decode(String.self, forKey: .streetName)
        city = try values.decode(String.self, forKey: .city)
        zipcode = try values.decode(String.self, forKey: .zipcode)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(cupcakeTypeIndex, forKey: .cupcakeTypeIndex)
        try container.encode(numberOfCakes, forKey: .numberOfCakes)
        try container.encode(hasSpecialRequest, forKey: .hasSpecialRequest)
        try container.encode(hasExtraSprinkles, forKey: .hasExtraSprinkles)
        try container.encode(name, forKey: .name)
        try container.encode(streetName, forKey: .streetName)
        try container.encode(city, forKey: .city)
        try container.encode(zipcode, forKey: .zipcode)
    }

}
