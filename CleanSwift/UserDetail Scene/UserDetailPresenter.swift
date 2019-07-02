//
//  UserDetailPresenter.swift
//  CleanSwift
//
//  Created by Josep Escobar on 30/06/2019.
//  Copyright (c) 2019 Josep Escobar. All rights reserved.
//

import UIKit

protocol UserDetailPresentationLogic {
    func presentInitialData(response: UserDetail.LoadData.Response)
}

class UserDetailPresenter: UserDetailPresentationLogic {
    weak var viewController: UserDetailDisplayLogic?

    // MARK: Do something
    func presentInitialData(response: UserDetail.LoadData.Response) {
        let user = response.user
        let viewModel = UserDetail.LoadData.ViewModel(user: user)
        viewController?.displayInitialData(viewModel: viewModel)
    }
}
