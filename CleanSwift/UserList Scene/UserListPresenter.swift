//
//  UserListPresenter.swift
//  CleanSwift
//
//  Created by Josep Escobar on 30/06/2019.
//  Copyright (c) 2019 Josep Escobar. All rights reserved.
//

import UIKit

protocol UserListPresentationLogic {
    func presentData(response: UserList.LoadData.Response)
    func presentUserDetail(response: UserList.UserDetail.Response)
    func presentSearchResults(response: UserList.SearchData.Response)
    func presentSearchCancel(response: UserList.SearchCancel.Response)
}

class UserListPresenter: UserListPresentationLogic {
    weak var viewController: UserListDisplayLogic?

    // MARK: Do something

    func presentData(response: UserList.LoadData.Response) {
        let viewModel = UserList.LoadData.ViewModel(users: response.users)
        viewController?.displayInitialData(viewModel: viewModel)
    }

    func presentUserDetail(response: UserList.UserDetail.Response) {
        let viewModel = UserList.UserDetail.ViewModel()
        viewController?.displayUserDetail(viewModel: viewModel)
    }

    func presentSearchResults(response: UserList.SearchData.Response) {
        let viewModel = UserList.SearchData.ViewModel(users: response.users)
        viewController?.displaySearchResults(viewModel: viewModel)
    }

    func presentSearchCancel(response: UserList.SearchCancel.Response) {
        let viewModel = UserList.SearchCancel.ViewModel()
        viewController?.displaySearchResultsCanceled(viewModel: viewModel)
    }

}
