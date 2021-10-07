//
//  ReceipeViewModel.swift
//  FetchRewards
//
//  Created by Hari Bista on 10/6/21.
//  Copyright © 2021 Hari Bista. All rights reserved.
//

import UIKit

class ReceipeViewModel {
    var categoryList: CategoryList?
    var mealSummaryList: MealSummaryList?
    
    var selectedCategoryId: String?
    
    var selectedCategory: String? {
        guard let categories = categoryList?.categories,
            let selectedCategoryId = selectedCategoryId else {
            return nil
        }
        
        for category in categories {
            if category.idCategory == selectedCategoryId {
                return category.strCategory
            }
        }
        
        return nil
    }
    
    func fetchCategoryList(completion: @escaping (Bool,Error?) -> Void) {
        guard let url = URL(string: "https://www.themealdb.com/api/json/v1/1/categories.php") else {
            completion(false,nil)
            return
        }
        
        ApiCaller().callApi(responseType: CategoryList.self, url: url) { result in
            switch result {
            case .success(let categoryList):
                self.categoryList = categoryList
                completion(true, nil)
            case .failure(let error):
                completion(false, error)
            }
        }
    }
    
    func fetchMealListBy(completion: @escaping (Bool,Error?) -> Void) {
        guard let selectedCategory = selectedCategory,
            let mealSummaryListUrl = URL(string: "https://www.themealdb.com/api/json/v1/1/filter.php?c=\(selectedCategory)") else {
            completion(false, nil)
            return
        }
        
        ApiCaller().callApi(responseType: MealSummaryList.self, url: mealSummaryListUrl) { result in
            switch result {
            case .success(let mealSummaryList):
                self.mealSummaryList = mealSummaryList
                completion(true, nil)
            case .failure(let error):
                completion(false, error)
            }
        }
    }
}
