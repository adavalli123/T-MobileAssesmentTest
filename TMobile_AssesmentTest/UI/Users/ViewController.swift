//
//  ViewController.swift
//  TMobile_AssesmentTest
//
//  Created by Varshini Thatiparthi on 3/30/20.
//  Copyright © 2020 Srikanth Adavalli. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private var filteredUsers: [Users]?
    @IBOutlet weak private var tableView: UITableView?
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var users: [Users] = [] {
        didSet {
            self.tableView?.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Constants.title
        
        setupTableView()
        setupSearchController()
        updateUserTableView()
    }
}

extension ViewController {
    private func setupTableView() {
        self.tableView?.tableFooterView = UIView()
        registerTableView()
    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = Constants.search
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func updateUserTableView() {
        ViewModal.handleUserAPI { [weak self] (users, error)  in
            DispatchQueue.main.async {
                guard let self = self else { return }
                
                if let _ = error {
                    // handle error scanerio
                }
                
                guard let users = users else { return }
                self.users = users
             }
         }
    }
    
    private func registerTableView() {
         self.tableView?.register(UINib(nibName: String(describing: UserTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: UserTableViewCell.self))
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if ViewModal.findSearchControllerIsActive(searchController) {
            return filteredUsers?.count ?? 0
        }
        
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UserTableViewCell.self), for: indexPath) as? UserTableViewCell else { return UITableViewCell() }
        
        if ViewModal.findSearchControllerIsActive(searchController) {
            guard let filteredUser = filteredUsers?[indexPath.row] else { return UITableViewCell() }
            cell.configure(imageViewUrl: filteredUser.avatarUrl, userName: filteredUser.login, login: filteredUser.login)
            return cell
        }
        
        let user = users[indexPath.row]
        cell.configure(imageViewUrl: user.avatarUrl, userName: user.login, login: user.login)
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailVC = UIStoryboard(name: Constants.userDetail, bundle: nil).instantiateViewController(identifier: String(describing: DetailViewController.self)) as? DetailViewController else { return }
        
        if ViewModal.findSearchControllerIsActive(searchController) {
            detailVC.login = filteredUsers?[indexPath.row].login
        } else {
            detailVC.login = users[indexPath.row].login
        }
        
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filteredUsers = ViewModal.filterContentForSearchText(searchBar.text, users: users)
        tableView?.reloadData()
    }
}

fileprivate extension ViewController {
    enum Constants {
        static let search = "Search for Users"
        static let title = "Github Searcher"
        static let userDetail = "UserDetail"
    }
}
