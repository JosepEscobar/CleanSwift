//
//  UserDetailPresenter.swift
//  CleanSwift
//
//  Created by Josep Escobar on 30/06/2019.
//  Copyright (c) 2019 Josep Escobar. All rights reserved.
//

import UIKit

protocol UserDetailPresentationLogic {
    func presentSomething(response: UserDetail.Something.Response)
}

class UserDetailPresenter: UserDetailPresentationLogic {
    weak var viewController: UserDetailDisplayLogic?

    // MARK: Do something

    func presentSomething(response: UserDetail.Something.Response) {
        let viewModel = UserDetail.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
}
