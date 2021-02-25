//
//  String+App.swift
//  News
//
//  Created by Mahesha on 25/02/21.
//

import Foundation

extension String {
    func formatDate() -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd,yyyy   HH:mm"
        if let date = dateFormatterGet.date(from: self) {
            return dateFormatter.string(from: date)
        } else {
           return ""
        }
    }
}
