//
//  UserDetailRouter.swift
//  CleanSwift
//
//  Created by Josep Escobar on 30/06/2019.
//  Copyright (c) 2019 Josep Escobar. All rights reserved.
//

import UIKit

@objc protocol UserDetailRoutingLogic {
}

protocol UserDetailDataPassing {
    var dataStore: UserDetailDataStore? { get }
}

class UserDetailRouter: NSObject, UserDetailRoutingLogic, UserDetailDataPassing {
    weak var viewController: UserDetailViewController?
    var dataStore: UserDetailDataStore?
}
