//
//  Owner.swift
//  BestSwiftRepo
//
//  Created by Thiago M Faria on 15/07/19.
//  Copyright © 2019 Thiago M Faria. All rights reserved.
//

import Foundation

// MARK: - Owner
struct Owner: Decodable {
    
    let login: String
    let avatarUrl: String
    
//    enum CodingKeys: String, CodingKey {
//        case login
//        case avatarURL = "avatar_url"
//    }
}
