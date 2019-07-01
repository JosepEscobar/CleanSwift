//
//  UserListWorker.swift
//  CleanSwift
//
//  Created by Josep Escobar on 30/06/2019.
//  Copyright (c) 2019 Josep Escobar. All rights reserved.
//

import UIKit

class UserListWorker {
    private var isBusy = false
    
    func fetchUsers(completionHandler: @escaping ([User]) -> Void) {
        guard !isBusy else { return }
        isBusy = true
        NetworkManager().getUsers { users in
            completionHandler(self.checkDuplicates(users: users))
            self.isBusy = false
        }
    }
    
    func fetchMoreUsers(oldUsersArray: [User], completionHandler: @escaping ([User]) -> Void) {
        guard !isBusy else { return }
        isBusy = true
        NetworkManager().getUsers { users in
            var mergedArray = oldUsersArray
            mergedArray.append(contentsOf: users)
            completionHandler(self.checkDuplicates(users: mergedArray))
            self.isBusy = false
        }
    }
    
    private func checkDuplicates(users: [User]) -> [User] {
        return users.uniqueElements
    }
}
