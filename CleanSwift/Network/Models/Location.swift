//
//  Location.swift
//  CleanSwift
//
//  Created by Josep Escobar on 01/07/2019.
//  Copyright © 2019 Josep Escobar. All rights reserved.
//

import Foundation

struct Location: Codable {
    let street: String?
    let city: String?
    let state: String?
    let postcode: String?
    let coordinates: Coordinates?
    let timezone: TimeZone?

    struct Coordinates: Codable {
        let latitude: String?
        let longitude: String?
    }

    struct TimeZone: Codable {
        let offset: String?
        let description: String?
    }

    enum CodingKeys: String, CodingKey {
        case street
        case city
        case state
        case postcode
        case coordinates
        case timezone
    }

    /// Used to init postalcode correctly. API can be return postcode type with String and Int
    ///
    /// - Parameter decoder: decoder
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.street = try container.decode(String.self, forKey: .street)
        self.city = try container.decode(String.self, forKey: .city)
        self.state = try container.decode(String.self, forKey: .state)
        self.coordinates = try container.decode(Coordinates.self, forKey: .coordinates)
        self.timezone = try container.decode(TimeZone.self, forKey: .timezone)

        let postCodeString = try? container.decode(String.self, forKey: .postcode)
        let postCodeInt = try? container.decode(Int.self, forKey: .postcode)
        self.postcode = postCodeString ?? "\(postCodeInt ?? 0)"
    }
}
