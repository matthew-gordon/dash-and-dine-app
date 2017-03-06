//
//  MealListTableViewController.swift
//  dash-and-dine-mobile
//
//  Created by Matt Gordon on 3/2/17.
//  Copyright © 2017 Matt Gordon. All rights reserved.
//

import UIKit

class MealListTableViewController: UITableViewController {
    
    var restaurant: Restaurant?
    var meals = [Meal]()
    
    let activityIndicator = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let restaurantName = restaurant?.name {
            self.navigationItem.title = restaurantName
        }

        loadMeals()
    }
    
    func loadMeals() {
    
        Helpers.showActivityIndicator(activityIndicator, view)
        if let restaurantId = restaurant?.id {
        
            APIManager.shared.getAllMeals(restaurantId: restaurantId, completionHandler: { (json) in
              
                // print(json)
                
                if json != nil {
                    self.meals = []
                    
                    if let tempMeals = json["meals"].array {
                        
                        for item in tempMeals {
                            
                            let meal = Meal(json: item)
                            self.meals.append(meal)
                            
                        }
                        
                        self.tableView.reloadData()
                        Helpers.hideActivityIndicator(self.activityIndicator, self.view)
                    }
                }
            })
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "MealDetails" {
            let controller = segue.destination as! MealDetailsViewController
            controller.meal = meals[(tableView.indexPathForSelectedRow?.row)!]
            
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MealCell", for: indexPath) as! MealViewCell
        
        let meal = meals[indexPath.row]
        cell.lbMealName.text = meal.name
        cell.lbMealShortDescription.text = meal.short_description
        
        if let price = meal.price {
            cell.lbMealPrice.text = "$\(price)"
        }
        print(meal.image!)
        
        if let image = meal.image {
            Helpers.loadImage(cell.imgMealImage, "\(image)")
        }
        return cell
    }
}
