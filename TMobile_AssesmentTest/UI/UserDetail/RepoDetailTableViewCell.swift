//
//  RepoDetailTableViewCell.swift
//  TMobile_AssesmentTest
//
//  Created by Varshini Thatiparthi on 3/31/20.
//  Copyright © 2020 Srikanth Adavalli. All rights reserved.
//

import UIKit

class RepoDetailTableViewCell: UITableViewCell {
    @IBOutlet weak private var repoNameLabel: UILabel?
    @IBOutlet weak private var forkLabel: UILabel?
    @IBOutlet weak private var starLabel: UILabel?
    
    func configure(name: String, fork: String, star: String) {
        self.selectionStyle = .none
        
        repoNameLabel?.text = Constants.repoName + Constants.space + name
        forkLabel?.text = fork + Constants.space + Constants.forks
        starLabel?.text = star + Constants.space + Constants.stars
    }
    
    private enum Constants {
        static let space = " "
        static let repoName = "Repo Name:"
        static let forks = "Forks"
        static let stars = "Stars"
    }
}

