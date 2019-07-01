//
//  UserListRouter.swift
//  CleanSwift
//
//  Created by Josep Escobar on 30/06/2019.
//  Copyright (c) 2019 Josep Escobar. All rights reserved.
//

import UIKit

@objc protocol UserListRoutingLogic {
    func routeToDetail()
}

protocol UserListDataPassing {
    var dataStore: UserListDataStore? { get }
}

class UserListRouter: NSObject, UserListRoutingLogic, UserListDataPassing {
    weak var viewController: UserListViewController?
    var dataStore: UserListDataStore?

    // MARK: Routing
    func routeToDetail() {
        let storyboard = UIStoryboard(name: "UserDetail", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "UserDetailViewController") as! UserDetailViewController
        var destinationDS = destinationVC.router!.dataStore!
        passDataToDetail(source: dataStore!, destination: &destinationDS)
        navigateToDetail(source: viewController!, destination: destinationVC)
    }

    // MARK: Navigation

    func navigateToDetail(source: UserListViewController, destination: UserDetailViewController) {
        source.show(destination, sender: nil)
    }

    // MARK: Passing data

    func passDataToDetail(source: UserListDataStore, destination: inout UserDetailDataStore) {
        destination.user = source.user
    }
}
