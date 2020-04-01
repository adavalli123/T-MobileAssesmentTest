//
//  UserDetail.swift
//  TMobile_AssesmentTest
//
//  Created by Varshini Thatiparthi on 3/31/20.
//  Copyright © 2020 Srikanth Adavalli. All rights reserved.
//

import Foundation

struct UserDetail: Decodable {
    let email: String?
    let location: String?
    let createdAt: Date
    let followers: Int
    let following: Int
    let bio: String?
    let avatarUrl: String
}
