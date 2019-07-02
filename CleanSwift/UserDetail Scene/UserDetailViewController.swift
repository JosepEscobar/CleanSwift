//
//  UserDetailViewController.swift
//  CleanSwift
//
//  Created by Josep Escobar on 30/06/2019.
//  Copyright (c) 2019 Josep Escobar. All rights reserved.
//

import UIKit

protocol UserDetailDisplayLogic: class {
    func displayInitialData(viewModel: UserDetail.LoadData.ViewModel)
}

class UserDetailViewController: UIViewController, UserDetailDisplayLogic {
    var interactor: UserDetailBusinessLogic?
    var router: (NSObjectProtocol & UserDetailRoutingLogic & UserDetailDataPassing)?

    // MARK: Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: Setup
    private func setup() {
        let viewController = self
        let interactor = UserDetailInteractor()
        let presenter = UserDetailPresenter()
        let router = UserDetailRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    // MARK: Routing
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }

    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        doLoadData()
    }

    // MARK: Do something

    //@IBOutlet weak var nameTextField: UITextField!

    func doLoadData() {
        let request = UserDetail.LoadData.Request()
        interactor?.doLoadInitialData(request: request)
    }

    func displayInitialData(viewModel: UserDetail.LoadData.ViewModel) {
        //nameTextField.text = viewModel.name
    }
}
