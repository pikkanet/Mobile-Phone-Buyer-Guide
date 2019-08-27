//
//  Model.swift
//  Mobile Phone Buyer Guide
//
//  Created by Pikkanet Chokwattanapornchai on 27/8/2562 BE.
//  Copyright © 2562 SCB. All rights reserved.
//

//let mobileResponse = try? newJSONDecoder().decode(MobileResponse.self, from: jsonData)

import Foundation

struct MobileResponseElement: Codable {
    let rating: Double
    let id: Int
    let thumbImageURL: String
    let price: Double
    let brand, name: String
    let isFavourite: Bool? = false
    let mobileResponseDescription: String
    
    enum CodingKeys: String, CodingKey {
        case rating, id, thumbImageURL, price, brand, name, isFavourite
        case mobileResponseDescription = "description"
    }
}

typealias MobileResponse = [MobileResponseElement]
