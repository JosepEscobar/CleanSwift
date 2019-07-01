//
//  UserResponse.swift
//  CleanSwift
//
//  Created by Josep Escobar on 01/07/2019.
//  Copyright © 2019 Josep Escobar. All rights reserved.
//

import Foundation

struct UserResponse: Codable {
    let results: [User]
    let info: Info

    struct Info: Codable {
        let seed: String?
        let results: Int?
        let page: Int?
        let version: String?
    }
}
