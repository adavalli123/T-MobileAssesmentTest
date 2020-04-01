//
//  DetailViewController_TableViewDataSource.swift
//  TMobile_AssesmentTest
//
//  Created by Varshini Thatiparthi on 3/31/20.
//  Copyright © 2020 Srikanth Adavalli. All rights reserved.
//

import UIKit

extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if DetailViewModal.findTextFieldIsActive(searchField?.text ?? "") && searchFieldIsActive {
            return filteredRepos?.count ?? 0
        }
        
        return repos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RepoDetailTableViewCell.self), for: indexPath) as? RepoDetailTableViewCell else { return UITableViewCell() }
        
        if DetailViewModal.findTextFieldIsActive(searchField?.text ?? "") && searchFieldIsActive {
            guard let repo = filteredRepos?[indexPath.row] else { return UITableViewCell() }
            cell.configure(name: repo.name, fork: String(repo.forks), star: String(repo.stargazersCount))
            return cell
        }
        
        let repo = repos[indexPath.row]
        cell.configure(name: repo.name, fork: String(repo.forks), star: String(repo.stargazersCount))
        return cell
    }
}
