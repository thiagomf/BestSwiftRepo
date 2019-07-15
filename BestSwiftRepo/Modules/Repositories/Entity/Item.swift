//
//  Item.swift
//  BestSwiftRepo
//
//  Created by Thiago M Faria on 15/07/19.
//  Copyright © 2019 Thiago M Faria. All rights reserved.
//

import Foundation

// MARK: - Item
struct Item: Codable {
    
    let name, fullName: String
    let owner: Owner
    let stargazersCount: Int
    
    enum CodingKeys: String, CodingKey {
        
        case name
        case fullName = "full_name"
        case owner
        case stargazersCount = "stargazers_count"
    }
}
