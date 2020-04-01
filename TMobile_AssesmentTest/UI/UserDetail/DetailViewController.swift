//
//  DetailViewController.swift
//  TMobile_AssesmentTest
//
//  Created by Varshini Thatiparthi on 3/31/20.
//  Copyright © 2020 Srikanth Adavalli. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView?
    @IBOutlet private weak var avatar: UIImageView?
    @IBOutlet private weak var nameLabel: UILabel?
    @IBOutlet private weak var emailLabel: UILabel?
    @IBOutlet private weak var locationLabel: UILabel?
    @IBOutlet private weak var joinDateLabel: UILabel?
    @IBOutlet private weak var followersLabel: UILabel?
    @IBOutlet private weak var followingLabel: UILabel?
    @IBOutlet private weak var bioLabel: UILabel?
    @IBOutlet private (set) weak var searchField: UITextField?
    
    var login: String?
    var filteredRepos: [Repos]?
    var searchFieldIsActive = false
    
    private (set) var repos: [Repos] = [] {
        didSet {
            self.tableView?.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Constants.title
        searchField?.delegate = self
        
        handleReponsewApi()
        handleUserDetailApi()
        registerTableView()
    }
    
    private func handleReponsewApi() {
        DetailViewModal.handleReposAPICall(login: login ?? "") { [weak self] (repos, _) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                guard let repos = repos else { return }
                self.repos  = repos
            }
        }
    }
    
    private func handleUserDetailApi() {
        DetailViewModal.handleUserDetailAPICall(login: login ?? "") { [weak self] (userDetail, _) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                guard let userDetail = userDetail else { return }
                self.config(url: userDetail.avatarUrl, name: self.login, email: userDetail.email, location: userDetail.location, joinDate: userDetail.createdAt, followers: userDetail.followers, following: userDetail.following, bio: userDetail.bio)
            }
        }
    }
    
    private func config(url: String, name: String?, email: String?, location: String?, joinDate: Date?, followers: Int?, following: Int?, bio: String?) {
        self.avatar?.getImage(from: url)
        self.nameLabel?.text = Constants.name + (name ?? "--")
        self.emailLabel?.text = Constants.email + (email ?? "--")
        self.locationLabel?.text = Constants.location + (location ?? "--")
        
        if let dateCreated = joinDate {
            self.joinDateLabel?.text = Constants.dateCreation + String(describing: dateCreated)
        } else {
            self.joinDateLabel?.text = Constants.dateCreation + "--"
        }
        
        if let followers = followers {
            self.followersLabel?.text = String(describing: followers) + Constants.followers
        } else {
            self.followersLabel?.text = "--" + Constants.followers
        }
        
        if let following = following {
            self.followingLabel?.text = Constants.following + String(describing: following)
        } else {
            self.followingLabel?.text = Constants.following + "--"
        }
        
        self.bioLabel?.text = Constants.bio + (bio ?? "")
    }
    
    private func hideUnwantedLabels(from string: String?, label: UILabel?) {
        if string == nil {
            guard let label = label else { return }
            label.isHidden = true
        } else {
            label?.isHidden = false
            label?.text = string
        }
    }
    
    private func registerTableView() {
        tableView?.dataSource = self
        tableView?.delegate = self
        self.tableView?.register(UINib(nibName: String(describing: RepoDetailTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: RepoDetailTableViewCell.self))
    }
}

private extension DetailViewController {
    enum Constants {
        static let title = "Github Searcher"
        static let name = "Name: "
        static let email = "Email: "
        static let location = "Location "
        static let dateCreation = "Account Created: "
        static let following = "Following "
        static let followers = " Followers"
        static let bio = "Bio: "
    }
}
