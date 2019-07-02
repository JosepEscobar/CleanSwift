//
//  User.swift
//  CleanSwift
//
//  Created by Josep Escobar on 01/07/2019.
//  Copyright © 2019 Josep Escobar. All rights reserved.
//

import Foundation

struct User: Codable, Equatable {

    let gender: String?
    let name: Name?
    let location: Location?
    let email: String?
    let login: Login?
    let dob: Dob?
    let registered: Registered?
    let phone: String?
    let cell: String?
    let id: Id?
    let picture: Picture?
    let nat: String?

    struct Name: Codable {
        let title: String?
        let first: String?
        let last: String?
    }

    struct Login: Codable {
        let uuid: String?
        let username: String?
        let password: String?
        let salt: String?
        let md5: String?
        let sha1: String?
        let sha256: String?
    }

    struct Dob: Codable {
        let date: String?
        let age: Int?
    }

    struct Registered: Codable {
        let date: String?
        let age: Int?
    }

    struct Id: Codable {
        let name: String?
        let value: String?
    }

    struct Picture: Codable {
        let large: String?
        let medium: String?
        let thumbnail: String?
    }

    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.login?.uuid == rhs.login?.uuid
    }
}
