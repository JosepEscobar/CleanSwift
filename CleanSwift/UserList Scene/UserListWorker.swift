//
//  UserListWorker.swift
//  CleanSwift
//
//  Created by Josep Escobar on 30/06/2019.
//  Copyright (c) 2019 Josep Escobar. All rights reserved.
//

import UIKit

class UserListWorker {
    func fetchUsers(completionHandler: @escaping ([User]) -> Void) {
        NetworkManager().getUsers { users in
            completionHandler(users)
        }
    }
}
