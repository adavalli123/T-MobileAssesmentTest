//
//  UserTableViewCell.swift
//  TMobile_AssesmentTest
//
//  Created by Varshini Thatiparthi on 3/30/20.
//  Copyright © 2020 Srikanth Adavalli. All rights reserved.
//

import UIKit

let repoCache = NSCache<NSString, NSString>()

final class UserTableViewCell: UITableViewCell {
    @IBOutlet weak private var userImageView: UIImageView?
    @IBOutlet weak private var userNameLabel: UILabel?
    @IBOutlet weak private var userReposCountLabel: UILabel?
    
    func configure(imageViewUrl: String, userName: String, login: String) {
        self.selectionStyle = .none
        
        userImageView?.getImage(from: imageViewUrl)
        userNameLabel?.text = userName
        
        if let repos = UserCellViewModal.cache.object(forKey: login as NSString) {
            self.userReposCountLabel?.text = Constants.repo + String(repos)
        } else {
            ViewModal.handleRepoCountAPICall(login: login) { [weak self] (repos, error)  in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    guard let repos = repos else { return }
                    self.userReposCountLabel?.text = Constants.repo + String(repos.count)
                    UserCellViewModal.cache.setObject(String(repos.count) as NSString, forKey: login as NSString)
                }
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        userImageView?.image = nil
        userNameLabel?.text = nil
        userReposCountLabel?.text = nil
    }
    
    private enum Constants {
        static let repo = "Repo: "
    }
}

struct UserCellViewModal {
    static let cache = NSCache<NSString, NSString>()
}
