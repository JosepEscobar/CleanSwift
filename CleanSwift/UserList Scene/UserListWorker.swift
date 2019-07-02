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
    let blackListKey = "blacklist"

    func fetchUsers(completionHandler: @escaping ([User]) -> Void) {
        guard !isBusy else { return }
        isBusy = true
        NetworkManager().getUsers { users in
            completionHandler(self.filterBlackList(users: users.uniqueElements))
            self.isBusy = false
        }
    }

    func fetchMoreUsers(oldUsersArray: [User], completionHandler: @escaping ([User]) -> Void) {
        guard !isBusy else { return }
        isBusy = true
        NetworkManager().getUsers { users in
            var mergedArray = oldUsersArray
            mergedArray.append(contentsOf: users)
            completionHandler(self.filterBlackList(users: mergedArray.uniqueElements))
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

    func addUserToBlackList(user: User) {
        guard let uuid = user.login?.uuid else {
            return
        }

        var blacklistArray = UserDefaults.standard.array(forKey: blackListKey)
        if let _ = blacklistArray {
            blacklistArray?.append(uuid)
        } else {
            blacklistArray = [uuid]
        }

        UserDefaults.standard.set(blacklistArray, forKey: blackListKey)
    }

    func filterBlackList(users: [User]) -> [User] {
        guard let blacklistArray = UserDefaults.standard.array(forKey: blackListKey) as? [String] else {
            return users
        }
        let filteredUsers = users.filter({(user: User) -> Bool in
            guard let uuid = user.login?.uuid else {
                return false
            }
            return !blacklistArray.contains(uuid)
        })

        return filteredUsers
    }

}
