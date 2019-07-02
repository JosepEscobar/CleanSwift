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
                return user.gender ?? "No gender"
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
                
                return location
            }
            
            func getRegisteredDate() -> String {
                guard let registeredDate = user.registered?.date else {
                    return "No registered date"
                }
                return registeredDate
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
