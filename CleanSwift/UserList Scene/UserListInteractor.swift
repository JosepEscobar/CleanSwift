//
//  UserListInteractor.swift
//  CleanSwift
//
//  Created by Josep Escobar on 30/06/2019.
//  Copyright (c) 2019 Josep Escobar. All rights reserved.
//

import UIKit

protocol UserListBusinessLogic {
    func doLoadInitialData(request: UserList.LoadData.Request)
    func doLoadMoreData(request: UserList.LoadData.Request)
    func doLoadUserDetail(request: UserList.UserDetail.Request)
    func doLoadResults(request: UserList.SearchData.Request)
    func doCancelSearch(request: UserList.SearchCancel.Request)
    func doDeleteUser(request: UserList.DeleteUser.Request)
}

protocol UserListDataStore {
    var user: User? { get set }
}

class UserListInteractor: UserListBusinessLogic, UserListDataStore {

    var presenter: UserListPresentationLogic?
    var worker: UserListWorker?
    var user: User?

    // MARK: Do something
    func doLoadInitialData(request: UserList.LoadData.Request) {
        worker = UserListWorker()
        worker?.fetchUsers(completionHandler: { users in
            let response = UserList.LoadData.Response(users: users)
            self.presenter?.presentData(response: response)
        })
    }

    func doLoadMoreData(request: UserList.LoadData.Request) {
        if let usersArray = request.users {
            worker = UserListWorker()
            worker?.fetchMoreUsers(oldUsersArray: usersArray, completionHandler: { users in
                let response = UserList.LoadData.Response(users: users)
                self.presenter?.presentData(response: response)
            })
        }
    }

    func doLoadUserDetail(request: UserList.UserDetail.Request) {
        user = request.user
        let response = UserList.UserDetail.Response()
        presenter?.presentUserDetail(response: response)
    }

    func doLoadResults(request: UserList.SearchData.Request) {
        let searchText = request.searchWord
        let users = request.users
        worker = UserListWorker()
        worker?.filterArrayBySearchText(searchText: searchText, usersArray: users, completionHandler: { users in
            let response = UserList.SearchData.Response(users: users)
            self.presenter?.presentSearchResults(response: response)
        })
    }

    func doCancelSearch(request: UserList.SearchCancel.Request) {
        let response = UserList.SearchCancel.Response()
        presenter?.presentSearchCancel(response: response)
    }

    func doDeleteUser(request: UserList.DeleteUser.Request) {
        var firstUsersArray = request.firstUsersArray
        var secondUsersArray = request.secondUsersArray
        let indexPath = request.indexPath
        worker = UserListWorker()

        worker?.addUserToBlackList(user: firstUsersArray[indexPath.row])
        if let users = worker?.filterBlackList(users: firstUsersArray) {
            firstUsersArray = users
        }
        if let users = worker?.filterBlackList(users: secondUsersArray) {
            secondUsersArray = users
        }

        let response = UserList.DeleteUser.Response(indexPath: indexPath, firstUsersArray: firstUsersArray, secondUsersArray: secondUsersArray)
        presenter?.presentDeletedUserFromArray(response: response)
    }

}
