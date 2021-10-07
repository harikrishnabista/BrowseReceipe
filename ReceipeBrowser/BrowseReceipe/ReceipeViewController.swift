//
//  ReceipeViewController.swift
//  FetchRewards
//
//  Created by Hari Bista on 10/6/21.
//  Copyright © 2021 Hari Bista. All rights reserved.
//

import UIKit

class ReceipeViewController: UIViewController {
    
    private var viewModel = ReceipeViewModel()
    
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var mealTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.categoryCollectionView.dataSource = self
        self.categoryCollectionView.delegate = self
        
        self.mealTableView.dataSource = self
        self.mealTableView.delegate = self
        
        self.styleMealTableView()
        
        self.loadCategories()
    }
    
    private func styleMealTableView(){
        self.mealTableView.tableFooterView = UIView(frame: .zero)
        
        self.mealTableView.layer.cornerRadius = 5.0
        self.mealTableView.layer.borderColor = UIColor.lightGray.cgColor
        self.mealTableView.layer.borderWidth = 0.5
        
        self.mealTableView.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func loadCategories() {
        
        //TODO:- show loading UI
        
        self.viewModel.fetchCategoryList(completion: { (success, error) in
            DispatchQueue.main.async {
                
                //TODO:- hide loading UI
                
                if success {
                    self.categoryCollectionView.reloadData()
                    self.categoryCollectionView.setNeedsDisplay()
                } else {
                    // TODO:- show error UI
                    print(error.debugDescription)
                }
            }
        })
    }
    
    private func loadMealListForSelectedCategory() {
        
        //TODO:- show loading UI
        self.mealTableView.isHidden = true
        
        self.viewModel.fetchMealListBy { (success, error) in
            DispatchQueue.main.async {
                
                //TODO:- hide loading UI
                
                if success {
                    self.mealTableView.isHidden = false
                    self.mealTableView.reloadData()
                    
                    self.mealTableView.setNeedsDisplay()
                    
                } else {
                    // TODO:- show error UI
                    print(error.debugDescription)
                }
            }
        }
    }
    
    @IBAction func reloadCollectionViewTapped(_ sender: Any) {
        self.categoryCollectionView.reloadData()
    }
    
    @IBAction func refreshButtonTapped(_ sender: Any) {
        self.loadCategories()
    }
}

extension ReceipeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.categoryList?.categories.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        
        if let categoryItem = self.viewModel.categoryList?.categories[indexPath.row] {
            var isSelected = false
            if let selectedCategoryId = self.viewModel.selectedCategoryId, selectedCategoryId == categoryItem.idCategory {
                print(categoryItem.strCategory)
                isSelected = true
            }
            cell.displayData(categoryItem: categoryItem, isSelected: isSelected)
        }
        
        return cell
    }
}

extension ReceipeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let selectedCategoryId = self.viewModel.categoryList?.categories[indexPath.row].idCategory {
            self.viewModel.selectedCategoryId = selectedCategoryId
            self.categoryCollectionView.reloadData()
            self.loadMealListForSelectedCategory()
        }
    }
}

extension ReceipeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.mealSummaryList?.meals.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MealCell", for: indexPath) as! MealCell
        if let mealItem = self.viewModel.mealSummaryList?.meals[indexPath.row] {
            cell.displayData(mealItem: mealItem)
        }
        return cell
    }
}

extension ReceipeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mealItem = self.viewModel.mealSummaryList?.meals[indexPath.row]
        if let detailsVC = self.storyboard?.instantiateViewController(withIdentifier: "MealDetailsViewController") as? MealDetailsViewController {
            detailsVC.title = mealItem?.strMeal
            detailsVC.mealId = mealItem?.idMeal
            self.navigationController?.pushViewController(detailsVC, animated: true)
        }
    }
}

