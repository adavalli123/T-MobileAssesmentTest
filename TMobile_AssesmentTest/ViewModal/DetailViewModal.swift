//
//  DetailViewModal.swift
//  TMobile_AssesmentTest
//
//  Created by Varshini Thatiparthi on 3/31/20.
//  Copyright © 2020 Srikanth Adavalli. All rights reserved.
//

import UIKit

struct DetailViewModal {
    static func handleUserDetailAPICall(login: String, completion: @escaping (UserDetail?, ErrorType?) -> ()) {
        APIResponse.handle(url: login, decodingType: UserDetail.self) { (userDetail, error) in
            completion(userDetail, error)
        }
    }
    
    static func handleReposAPICall(login: String, completion: @escaping ([Repos]?, ErrorType?) -> ()) {
        let userRepo =  login + "/repos"
        APIResponse.handle(url: userRepo, decodingType: [Repos].self) { (repos, error) in
            completion(repos, error)
        }
    }
    
    static func filterContentForSearchText(_ searchText: String?, users: [Repos]?) -> [Repos]? {
        return users?.filter({ (user) -> Bool in
            return user.name.lowercased().contains(searchText?.lowercased() ?? "")
        })
    }
    
    static func findTextFieldIsActive(_ text: String) -> Bool {
        return (text.isEmpty == false)
    }

}
