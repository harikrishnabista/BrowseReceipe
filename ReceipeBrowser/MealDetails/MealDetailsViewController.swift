//
//  MealDetailsViewController.swift
//  ReceipeBrowser
//
//  Created by Hari Bista on 10/6/21.
//  Copyright © 2021 Hari Bista. All rights reserved.
//

import UIKit

enum InstructionButtonType: String {
    case Show
    case Hide
}

class MealDetailsViewController: UIViewController {
    var mealId: String?
    
    @IBOutlet weak var mealThubmImageView: UIImageView!
    private var viewModel = MealDetailsViewModel()
    @IBOutlet weak var InstructionsHeadingLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var mainStackView: UIStackView!
    @IBOutlet weak var instructionsLabel: UILabel!
    @IBOutlet weak var instructionCollapseButton: UIButton!
    
    @IBOutlet weak var instructionStackView: UIStackView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadMealDetails()
    }
    
    private func initialSetup() {
        self.instructionStackView.isHidden = true
        self.viewModel.instructionButtonType = .Hide
    }
    
    private func loadMealDetails(){
        guard let mealId = self.mealId else {
            return
        }
        
        // TODO:- show loading UI
        
        self.viewModel.fetchMealDetails(mealId: mealId) { (success, error) in
            DispatchQueue.main.async {
                
                // TODO:- hide loading UI
                
                if success {
                    self.displayData()
                } else {
                    // TODO:- display error message on error UI
                    print(error.debugDescription)
                }
            }
        }
    }
    
    private func displayData() {
        guard let meal = self.viewModel.displayMealDetails else {
            return
        }

        self.instructionsLabel.text = meal.strInstructions
        
        self.mealThubmImageView.image = UIImage(named: "noImage")
        
        guard let url = URL(string: meal.strMealThumb) else { return }
        ImageDownloadHelper.shared.downloadImage(url: url) { image in
            DispatchQueue.main.async {
                self.mealThubmImageView.image = image
            }
        }
        
       self.displayIngrediantsMeasurments()
        
        self.instructionStackView.isHidden = false
    }
    
    private func displayIngrediantsMeasurments(){
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor.darkGray
        label.text = self.viewModel.ingredientListDisplayValue
        
        self.mainStackView.addArrangedSubview(label)
    }
    
    @IBAction func instructionCollapseButtonTapped(_ sender: Any) {
        if viewModel.instructionButtonType == .Hide {
            self.instructionsLabel.isHidden = true
            viewModel.instructionButtonType = .Show
        } else {
            self.instructionsLabel.isHidden = false
            viewModel.instructionButtonType = .Hide
        }
        self.instructionCollapseButton.setTitle(viewModel.instructionButtonType.rawValue, for: .normal)
        
        self.mainStackView.invalidateIntrinsicContentSize()
    }
}
