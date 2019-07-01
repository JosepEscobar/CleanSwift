//
//  User.swift
//  CleanSwift
//
//  Created by Josep Escobar on 01/07/2019.
//  Copyright © 2019 Josep Escobar. All rights reserved.
//

import Foundation

struct User: Codable {
    let gender: String
    let name: User.Name
    let location: User.Location
    let email: String
    let login: User.Login
    let dob: User.Dob
    let registered: User.Registered
    let phone: String
    let cell: String
    let id: User.Id
    let picture: User.Picture
    let nat: String
    
    struct Name: Codable {
        let title: String
        let first: String
        let last: String
    }
    
    struct Location: Codable {
        let street: String
        let city: String
        let state: String
        let postcode: Int
        let coordinates: Coordinates
        let timezone: TimeZone
    }
    
    struct Coordinates: Codable {
        let latitude: String
        let longitude: String
    }
    
    struct TimeZone: Codable {
        let offset: String
        let description: String
    }
    
    struct Login: Codable {
        let uuid: String
        let username: String
        let password: String
        let salt: String
        let md5: String
        let sha1: String
        let sha256: String
    }
    
    struct Dob: Codable {
        let date: String
        let age: Int
    }
    
    struct Registered: Codable {
        let date: String
        let age: Int
    }
    
    struct Id: Codable {
        let name: String
        let value: String
    }
    
    struct Picture: Codable {
        let large: String
        let medium: String
        let thumbnail: String
    }
}


