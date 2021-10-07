//
//  DataModels.swift
//  FetchRewards
//
//  Created by Hari Bista on 10/6/21.
//  Copyright © 2021 Hari Bista. All rights reserved.
//

import UIKit

// MARK: - CategoryList
struct CategoryList: Codable {
    let categories: [Category]
}

// MARK: - Category
struct Category: Codable {
    let idCategory, strCategory: String
    let strCategoryThumb: String
    let strCategoryDescription: String
}


// MARK: - MealList
struct MealSummaryList: Codable {
    let meals: [MealSummary]
}

// MARK: - Meal
struct MealSummary: Codable {
    let strMeal: String
    let strMealThumb: String
    let idMeal: String
}


// MARK: - MealDetails
struct MealDetails: Codable {
    let meals: [Meal]
}

// MARK: - Meal
struct Meal: Codable {
    let idMeal, strMeal: String
    let strDrinkAlternate: String?
    let strCategory, strArea, strInstructions: String
    let strMealThumb: String
    let strTags: String?
    let strYoutube, strSource: String
    let strImageSource, strCreativeCommonsConfirmed, dateModified: String?
    
    let strIngredient1, strIngredient2, strIngredient3, strIngredient4: String?
    let strIngredient5, strIngredient6, strIngredient7, strIngredient8: String?
    let strIngredient9, strIngredient10, strIngredient11, strIngredient12: String?
    let strIngredient13, strIngredient14, strIngredient15, strIngredient16: String?
    let strIngredient17, strIngredient18, strIngredient19, strIngredient20: String?
    let strMeasure1, strMeasure2, strMeasure3, strMeasure4: String?
    let strMeasure5, strMeasure6, strMeasure7, strMeasure8: String?
    let strMeasure9, strMeasure10, strMeasure11, strMeasure12: String?
    let strMeasure13, strMeasure14, strMeasure15, strMeasure16: String?
    let strMeasure17, strMeasure18, strMeasure19, strMeasure20: String?
}

extension Meal {
    var strIngredient: [String] {
        
        func getIngredients(for ingredient: String?, with measurment: String?) -> String? {
            guard let ingredient = ingredient, !ingredient.isEmpty,
                let measurment = measurment, !measurment.isEmpty else {
                    return nil
            }
            return ingredient + " : " + measurment
        }
        
        var result: [String] = []
        
        if let ingradient1 = getIngredients(for: strIngredient1, with: strMeasure1) {
            result.append(ingradient1)
        }
        
        if let ingradient1 = getIngredients(for: strIngredient2, with: strMeasure2) {
            result.append(ingradient1)
        }
        
        if let ingradient1 = getIngredients(for: strIngredient3, with: strMeasure3) {
            result.append(ingradient1)
        }
        
        if let ingradient1 = getIngredients(for: strIngredient4, with: strMeasure4) {
            result.append(ingradient1)
        }
        
        if let ingradient1 = getIngredients(for: strIngredient5, with: strMeasure5) {
            result.append(ingradient1)
        }
        
        if let ingradient1 = getIngredients(for: strIngredient6, with: strMeasure6) {
            result.append(ingradient1)
        }
        
        if let ingradient1 = getIngredients(for: strIngredient7, with: strMeasure7) {
            result.append(ingradient1)
        }
        
        if let ingradient1 = getIngredients(for: strIngredient8, with: strMeasure8) {
            result.append(ingradient1)
        }
        
        if let ingradient1 = getIngredients(for: strIngredient9, with: strMeasure9) {
            result.append(ingradient1)
        }
        
        if let ingradient1 = getIngredients(for: strIngredient10, with: strMeasure10) {
            result.append(ingradient1)
        }
        
        if let ingradient1 = getIngredients(for: strIngredient11, with: strMeasure11) {
            result.append(ingradient1)
        }
        
        if let ingradient1 = getIngredients(for: strIngredient12, with: strMeasure12) {
            result.append(ingradient1)
        }
        
        if let ingradient1 = getIngredients(for: strIngredient13, with: strMeasure13) {
            result.append(ingradient1)
        }
        
        if let ingradient1 = getIngredients(for: strIngredient14, with: strMeasure14) {
            result.append(ingradient1)
        }
        
        if let ingradient1 = getIngredients(for: strIngredient15, with: strMeasure15) {
            result.append(ingradient1)
        }
        
        if let ingradient1 = getIngredients(for: strIngredient16, with: strMeasure16) {
            result.append(ingradient1)
        }
        
        if let ingradient1 = getIngredients(for: strIngredient17, with: strMeasure17) {
            result.append(ingradient1)
        }
        
        if let ingradient1 = getIngredients(for: strIngredient18, with: strMeasure18) {
            result.append(ingradient1)
        }
        
        if let ingradient1 = getIngredients(for: strIngredient19, with: strMeasure19) {
            result.append(ingradient1)
        }
        
        if let ingradient1 = getIngredients(for: strIngredient20, with: strMeasure20) {
            result.append(ingradient1)
        }

        return result
    }
}

