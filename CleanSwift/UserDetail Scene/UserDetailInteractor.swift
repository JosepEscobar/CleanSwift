//
//  UserDetailInteractor.swift
//  CleanSwift
//
//  Created by Josep Escobar on 30/06/2019.
//  Copyright (c) 2019 Josep Escobar. All rights reserved.
//

import UIKit

protocol UserDetailBusinessLogic {
    func doSomething(request: UserDetail.Something.Request)
}

protocol UserDetailDataStore {
    var user: User? { get set }
}

class UserDetailInteractor: UserDetailBusinessLogic, UserDetailDataStore {
    var presenter: UserDetailPresentationLogic?
    var worker: UserDetailWorker?
    var user: User?
    //var name: String = ""

    // MARK: Do something

    func doSomething(request: UserDetail.Something.Request) {
        worker = UserDetailWorker()
        worker?.doSomeWork()

        let response = UserDetail.Something.Response()
        presenter?.presentSomething(response: response)
    }
}
