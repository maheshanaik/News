//
//  Repo.swift
//  Test
//
//  Created by Mahesha on 23/03/21.
//

import Foundation

struct Repos: Codable {
    var total_count: Int
    var items: [Repo]
}

struct Repo: Codable {
    var name: String
    var description: String?
    var owner: Owner
    var contributors_url: String
    var issues_url: String
}


struct Owner: Codable {
    var avatar_url: String
}


struct Contributor: Codable {
    var login: String
    var avatar_url: String
}


struct Issue: Codable {
    var title: String
}
