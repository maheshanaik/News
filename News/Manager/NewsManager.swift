//
//  NewsManager.swift
//  News
//
//  Created by Mahesha on 24/02/21.
//

import Foundation

class NewsManager {
   static let shared = NewsManager()
    private init() {}
    private var pageCount = 1
    private var apiManager = APIManager()
    
    func getNews(completion: @escaping (_ news: Articles?, _ error: APIManager.CustomError?) -> Void) {
        guard let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=79b25b150d504b818cab4c2dd000f59a&pageSize=10&page=\(pageCount)") else {
             return
        }
        apiManager.getData(fromURL: url) { result in
            guard let result = result else {
                return
            }
            if result.error == nil {
                let decoder = JSONDecoder()
                guard let data = result.data else {
                    return
                }
                do {
                    let articles =  try decoder.decode(Articles.self, from: data)
                    self.pageCount += 1
                    completion(articles, nil)
                } catch  {
                    completion(nil, .noData)
                }
                
                
            } else {
                completion(nil, result.error)
            }
            
        }
    }
}
