//
//  DetailViewController_TableViewDelegateSource.swift
//  TMobile_AssesmentTest
//
//  Created by Varshini Thatiparthi on 3/31/20.
//  Copyright © 2020 Srikanth Adavalli. All rights reserved.
//

import UIKit
import SafariServices

extension DetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var urlString = ""
        if DetailViewModal.findTextFieldIsActive(searchField?.text ?? "") && searchFieldIsActive {
            urlString = filteredRepos?[indexPath.row].owner.htmlUrl ?? ""
        } else {
            urlString = repos[indexPath.row].owner.htmlUrl
        }
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true, completion: nil)
    }
}
