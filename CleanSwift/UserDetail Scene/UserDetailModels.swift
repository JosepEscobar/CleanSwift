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
        }
    }
}
