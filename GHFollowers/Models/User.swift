//
//  User.swift
//  GHFollowers
//
//  Created by Doğan Ensar Papuçcuoğlu on 7.12.2024.
//

import Foundation

struct User: Codable {
    var login: String
    var avatarUrl: String
    var name: String?
    var location: String?
    var bio: String?
    var publicRepos: Int
    var publicGists: Int
    var followers: Int
    var following: Int
    var htmlUrl: String
    var createdAt: String
}
