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

}
