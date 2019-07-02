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
            completionHandler(users.uniqueElements)
            self.isBusy = false
        }
    }

    func fetchMoreUsers(oldUsersArray: [User], completionHandler: @escaping ([User]) -> Void) {
        guard !isBusy else { return }
        isBusy = true
        NetworkManager().getUsers { users in
            var mergedArray = oldUsersArray
            mergedArray.append(contentsOf: users)
            completionHandler(mergedArray.uniqueElements)
            self.isBusy = false
        }
    }

    func filterArrayBySearchText(searchText: String, usersArray: [User], completionHandler: @escaping ([User]) -> Void) {
        let filteredUsers = usersArray.filter({(user: User) -> Bool in
            guard let firstName = user.name?.first,
                  let lastName = user.name?.last else {
                    return false
            }
            let name = "\(firstName) \(lastName)"
            return name.lowercased().contains(searchText.lowercased())
        })

        completionHandler(filteredUsers)
    }

}
