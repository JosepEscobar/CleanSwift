//
//  DictionaryExtensions.swift
//  CleanSwift
//
//  Created by Josep Escobar on 01/07/2019.
//  Copyright © 2019 Josep Escobar. All rights reserved.
//
import Foundation

extension Dictionary {
    public var queryString: String {
        let urlParams = self.compactMap({ (key, value) -> String in
            return "\(key)=\(value)"
        }).joined(separator: "&")
        return urlParams
    }
}
