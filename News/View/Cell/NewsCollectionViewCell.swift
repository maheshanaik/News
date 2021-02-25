//
//  NewsCollectionViewCell.swift
//  News
//
//  Created by Mahesha on 24/02/21.
//

import UIKit
import Kingfisher

class NewsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var dateLabel: UILabel!
    
    static let identifier = "NewsCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateUI(news: Article) {
        titleLabel.text = news.title
        descriptionTextView.text = news.description
        dateLabel.text = news.publishedAt
        if let urlString = news.urlToImage, let url = URL(string: urlString) {
            let imageResource = ImageResource(downloadURL: url)
            thumbnailImageView.kf.setImage(with: imageResource, placeholder: nil, options: nil, completionHandler: nil)
        }
    }

}
