//
//  CategoryCell.swift
//  FetchRewards
//
//  Created by Hari Bista on 10/6/21.
//  Copyright © 2021 Hari Bista. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.categoryImageView.layer.cornerRadius = 8.0
        self.categoryImageView.clipsToBounds = true
    }
    
    func displayData(categoryItem: Category, isSelected: Bool){
        self.categoryLabel.text = categoryItem.strCategory
        
        // place holder image
        self.categoryImageView.image = UIImage(named: "noImage")
        
        if let url = URL(string: categoryItem.strCategoryThumb) {
            ImageDownloadHelper.shared.downloadImage(url: url) { (image) in
                DispatchQueue.main.async {
                    self.categoryImageView.image = image
                }
            }
        }
        
        if isSelected {
            self.categoryLabel.textColor = UIColor.blue
        } else {
            self.categoryLabel.textColor = UIColor.black
        }
    }
}
