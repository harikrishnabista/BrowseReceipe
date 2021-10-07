//
//  MealCell.swift
//  FetchRewards
//
//  Created by Hari Bista on 10/6/21.
//  Copyright © 2021 Hari Bista. All rights reserved.
//

import UIKit

class MealCell: UITableViewCell {

    @IBOutlet weak var meanImageView: UIImageView!
    @IBOutlet weak var meanLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func displayData(mealItem: MealSummary) {
        self.meanLabel.text = mealItem.strMeal
        
        // place holder image
        self.meanImageView.image = UIImage(named: "noImage")
        
        if let url = URL(string: mealItem.strMealThumb) {
            ImageDownloadHelper.shared.downloadImage(url: url) { (image) in
                DispatchQueue.main.async {
                    self.meanImageView.image = image
                    self.setNeedsDisplay()
                }
            }
        }
    }

}
