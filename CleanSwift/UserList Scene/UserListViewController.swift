//
//  UserListViewController.swift
//  CleanSwift
//
//  Created by Josep Escobar on 30/06/2019.
//  Copyright (c) 2019 Josep Escobar. All rights reserved.
//

import UIKit

protocol UserListDisplayLogic: class {
    func displayInitialData(viewModel: UserList.LoadData.ViewModel)
    func displayUserDetail(viewModel: UserList.UserDetail.ViewModel)
    func displaySearchResults(viewModel: UserList.SearchData.ViewModel)
    func displaySearchResultsCanceled(viewModel: UserList.SearchCancel.ViewModel)
    func displayDeleteRow(indexPath: IndexPath, firstUsersArray: [User], secondUsersArray: [User])
}

class UserListViewController: UIViewController, UserListDisplayLogic {

    var interactor: UserListBusinessLogic?
    var router: (NSObjectProtocol & UserListRoutingLogic & UserListDataPassing)?
    var viewModel = UserList.LoadData.ViewModel(users: [])
    var resultsViewModel = UserList.SearchData.ViewModel(users: [])
    var isSearching = false

    @IBOutlet weak var tableView: UITableView!
    let searchController = UISearchController(searchResultsController: nil)

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
        let interactor = UserListInteractor()
        let presenter = UserListPresenter()
        let router = UserListRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    // MARK: Routing
    func displayUserDetail(viewModel: UserList.UserDetail.ViewModel) {
        router?.routeToDetail()
    }

    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        loadInitialData()
    }

    // MARK: Do something
    func configureUI() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 90
        tableView.rowHeight = UITableView.automaticDimension
        tableView.keyboardDismissMode = .onDrag
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Users"
        searchController.searchBar.enablesReturnKeyAutomatically = true
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        definesPresentationContext = true
        title = NSLocalizedString("title_list_key", comment: "") 
    }

    func loadInitialData() {
        let request = UserList.LoadData.Request(users: nil)
        interactor?.doLoadInitialData(request: request)
    }

    func displayInitialData(viewModel: UserList.LoadData.ViewModel) {
        self.viewModel = viewModel
        tableView.reloadData()
    }

    func displaySearchResults(viewModel: UserList.SearchData.ViewModel) {
        self.resultsViewModel = viewModel
        isSearching = true
        tableView.reloadData()
    }

    func displaySearchResultsCanceled(viewModel: UserList.SearchCancel.ViewModel) {
        isSearching = false
        tableView.reloadData()
    }

    func displayDeleteRow(indexPath: IndexPath, firstUsersArray: [User], secondUsersArray: [User]) {
        if isSearching {
            resultsViewModel.users = firstUsersArray
            viewModel.users = secondUsersArray
        } else {
            viewModel.users = firstUsersArray
        }
        self.tableView.deleteRows(at: [indexPath], with: .fade)
    }
}

extension UserListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = viewModel.users[indexPath.row]
        let request = UserList.UserDetail.Request(user: user)
        interactor?.doLoadUserDetail(request: request)
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 5 == self.viewModel.getNumberOfUsers() {
            let request = UserList.LoadData.Request(users: self.viewModel.users)
            interactor?.doLoadMoreData(request: request)
        }
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            var request: UserList.DeleteUser.Request
            if isSearching {
                request = UserList.DeleteUser.Request(indexPath: indexPath, firstUsersArray: resultsViewModel.users, secondUsersArray: viewModel.users)
            } else {
                request = UserList.DeleteUser.Request(indexPath: indexPath, firstUsersArray: viewModel.users, secondUsersArray: resultsViewModel.users)
            }
            interactor?.doDeleteUser(request: request)
        }
    }
}

extension UserListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching ? resultsViewModel.getNumberOfUsers() : viewModel.getNumberOfUsers()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "UserListCell", for: indexPath) as? UserListTableViewCell {
            if isSearching {
                cell.setupCell(name: resultsViewModel.getfullUserName(index: indexPath.row),
                               avatarUrl: resultsViewModel.getAvatarImage(index: indexPath.row),
                               email: resultsViewModel.getEmail(index: indexPath.row),
                               phone: resultsViewModel.getPhone(index: indexPath.row))
            } else {
                cell.setupCell(name: viewModel.getfullUserName(index: indexPath.row),
                               avatarUrl: viewModel.getAvatarImage(index: indexPath.row),
                               email: viewModel.getEmail(index: indexPath.row),
                               phone: viewModel.getPhone(index: indexPath.row))
            }
            return cell
        } else {
            return UITableViewCell()
        }
    }

}

extension UserListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let searchWord = searchController.searchBar.text, !searchWord.isEmpty {
            let request = UserList.SearchData.Request(searchWord: searchWord, users: viewModel.users)
            interactor?.doLoadResults(request: request)
        }
    }
}

extension UserListViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        let request = UserList.SearchCancel.Request()
        interactor?.doCancelSearch(request: request)
    }
}
