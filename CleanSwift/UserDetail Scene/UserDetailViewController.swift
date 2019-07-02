//
//  UserDetailViewController.swift
//  CleanSwift
//
//  Created by Josep Escobar on 30/06/2019.
//  Copyright (c) 2019 Josep Escobar. All rights reserved.
//

import UIKit
import Kingfisher

protocol UserDetailDisplayLogic: class {
    func displayInitialData(viewModel: UserDetail.LoadData.ViewModel)
}

class UserDetailViewController: UIViewController, UserDetailDisplayLogic {
    var interactor: UserDetailBusinessLogic?
    var router: (NSObjectProtocol & UserDetailRoutingLogic & UserDetailDataPassing)?
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var registeredDateLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!

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
    func doLoadData() {
        let request = UserDetail.LoadData.Request()
        interactor?.doLoadInitialData(request: request)
    }

    func displayInitialData(viewModel: UserDetail.LoadData.ViewModel) {
        if let url = URL(string: viewModel.getAvatarImage()) {
            userImageView.kf.setImage(with: url)
            setCircleAvatar()
        }
        nameLabel.text = viewModel.getfullUserName()
        emailLabel.text = viewModel.getEmail()
        genderLabel.text = viewModel.getGender()
        locationLabel.text = viewModel.getLocation()
        registeredDateLabel.text = viewModel.getRegisteredDate()
    }
    
    private func setCircleAvatar() {
        userImageView.layer.masksToBounds = false
        userImageView.layer.borderColor = UIColor.black.cgColor
        userImageView.layer.cornerRadius = userImageView.frame.height/2
        userImageView.clipsToBounds = true
        userImageView.backgroundColor = .lightGray
    }
}
