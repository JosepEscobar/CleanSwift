//
//  UserDetailModels.swift
//  CleanSwift
//
//  Created by Josep Escobar on 30/06/2019.
//  Copyright (c) 2019 Josep Escobar. All rights reserved.
//

import UIKit

enum UserDetail {
    // MARK: Use cases

    enum LoadData {
        struct Request {
        }
        struct Response {
            let user: User
        }
        struct ViewModel {
            let user: User
            
            func getGender() -> String {
                return user.gender?.capitalized ?? "No gender"
            }
            
            func getLocation() -> String {
                var location: String = ""
                
                if let street = user.location?.street {
                    location = location + street
                }
                
                if let city = user.location?.city {
                    if !location.isEmpty {
                        location = location + ", "
                    }
                    location = location + city
                }
                
                if let state = user.location?.state {
                    if !location.isEmpty {
                        location = location + ", "
                    }
                    location = location + state
                }
                
                if location.isEmpty {
                    location = "No Location"
                }
                
                return location
            }
            
            func getRegisteredDate() -> String {
                guard let registeredDate = user.registered?.date else {
                    return "No registered date"
                }
                let dateFormatterGet = DateFormatter()
                dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                
                let dateFormatterPrint = DateFormatter()
                dateFormatterPrint.dateFormat = "MMM dd,yyyy"
                
                if let date = dateFormatterGet.date(from: registeredDate) {
                    return dateFormatterPrint.string(from: date)
                } else {
                    return registeredDate
                }
            }
            
            /// Format User name with First name and Last name
            ///
            /// - Returns: returns formated value, never returns nil
            func getfullUserName() -> String {
                guard let firstName = user.name?.first,
                    let lastName = user.name?.last else {
                        return "No name"
                }
                return "\(firstName) \(lastName)".capitalized
            }

            /// Get avatar URL
            ///
            /// - Returns: returns URL in String format, never returns nil
            func getAvatarImage() -> String {
                guard let avatarUrl = user.picture?.large else {
                    return ""
                }
                return avatarUrl
            }
            
            /// Get user Email
            ///
            /// - Returns: returns email value, never returns nil
            func getEmail() -> String {
                guard let email = user.email else {
                    return "No email"
                }
                return email
            }
        }
    }
}
