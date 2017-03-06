//
//  MealDetailsViewController.swift
//  dash-and-dine-mobile
//
//  Created by Matt Gordon on 3/2/17.
//  Copyright © 2017 Matt Gordon. All rights reserved.
//

import UIKit

class MealDetailsViewController: UIViewController {

    @IBOutlet weak var imgMealImage: UIImageView!
    @IBOutlet weak var lbMealName: UILabel!
    @IBOutlet weak var lbMealShortDescription: UILabel!
    
    var meal: Meal?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadMeal()
    }
    
    func loadMeal() {
    
        lbMealName.text = meal?.name
        lbMealShortDescription.text = meal?.short_description
        
        if let imageUrl = meal?.image {
            
            Helpers.loadImage(imgMealImage, "\(imageUrl)")
        }
    }
}
