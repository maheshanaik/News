//
//  Article.swift
//  News
//
//  Created by Mahesha on 24/02/21.
//

import Foundation

struct Article: Codable {
    var title: String
    var description: String?
    var urlToImage: String?
    var publishedAt: String?
}

struct Articles: Codable {
    var totalResults: Int
    var articles: [Article]
}
