//
//  MealDetailsViewModel.swift
//  ReceipeBrowser
//
//  Created by Hari Bista on 10/7/21.
//  Copyright © 2021 Hari Bista. All rights reserved.
//

import UIKit

class MealDetailsViewModel {
    
    var instructionButtonType = InstructionButtonType.Show
    
    var mealDetails: MealDetails?

    var displayMealDetails: Meal? {
        return self.mealDetails?.meals[0]
    }
    
    var ingredientListDisplayValue: String {
        var ingredientList = "Ingredients & measurements :".uppercased() + "\n\n"
        guard let meal = self.displayMealDetails else { return ingredientList }
        for ingredient in meal.strIngredient {
            ingredientList = ingredientList + ingredient + "\n"
        }
        return ingredientList
    }
    
    func fetchMealDetails(mealId: String, completion: @escaping (Bool,Error?) -> Void) {
        guard let mealDetailsUrl = URL(string: "https://www.themealdb.com/api/json/v1/1/lookup.php?i=\(mealId)") else {
            completion(false, nil)
            return
        }
        
        ApiCaller().callApi(responseType: MealDetails.self, url: mealDetailsUrl) { result in
            switch result {
            case .success(let mealDetails):
                self.mealDetails = mealDetails
                completion(true, nil)
            case .failure(let error):
                completion(false, error)
            }
        }
    }
}
