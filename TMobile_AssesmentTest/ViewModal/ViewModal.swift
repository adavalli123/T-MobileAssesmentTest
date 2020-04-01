//
//  ViewModal.swift
//  TMobile_AssesmentTest
//
//  Created by Varshini Thatiparthi on 3/30/20.
//  Copyright © 2020 Srikanth Adavalli. All rights reserved.
//

import Foundation
import UIKit

internal struct ViewModal {
    static func handleUserAPI(completion: @escaping ([Users]?, ErrorType?) -> ()) {
        APIResponse.handle(url: "", decodingType: [Users].self) { (users, error) in
            completion(users, error)
        }
    }
    
    static func handleRepoCountAPICall(login: String, completion: @escaping ([Repos]?, ErrorType?) -> ()) {
        let userRepo =  login + "/repos"
        APIResponse.handle(url: userRepo, decodingType: [Repos].self) { (repos, error) in
            completion(repos, error)
        }
    }
    
    static func findSearchControllerIsActive(_ searchController: UISearchController) -> Bool {
        return searchController.isActive && (searchController.searchBar.text?.isEmpty == false)
    }
    
    static func filterContentForSearchText(_ searchText: String?, users: [Users]?) -> [Users]? {
        return users?.filter({ (user) -> Bool in
            return user.login.lowercased().contains(searchText?.lowercased() ?? "")
        })
    }
}
