//
//  Repos.swift
//  TMobile_AssesmentTest
//
//  Created by Varshini Thatiparthi on 3/31/20.
//  Copyright © 2020 Srikanth Adavalli. All rights reserved.
//

import Foundation

struct Repos: Decodable {
    let forks: Int
    let stargazersCount: Int
    let owner: Owner
    let name: String
}
