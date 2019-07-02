//
//  UserDetailInteractor.swift
//  CleanSwift
//
//  Created by Josep Escobar on 30/06/2019.
//  Copyright (c) 2019 Josep Escobar. All rights reserved.
//

import UIKit

protocol UserDetailBusinessLogic {
    func doLoadInitialData(request: UserDetail.LoadData.Request)
}

protocol UserDetailDataStore {
    var user: User? { get set }
}

class UserDetailInteractor: UserDetailBusinessLogic, UserDetailDataStore {
    var presenter: UserDetailPresentationLogic?
    var worker: UserDetailWorker?
    var user: User?

    // MARK: Do something
    func doLoadInitialData(request: UserDetail.LoadData.Request) {
        guard let user = user else {
            return
        }
        let response = UserDetail.LoadData.Response(user: user)
        presenter?.presentInitialData(response: response)
    }
}
