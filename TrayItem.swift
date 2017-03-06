//
//  TrayItem.swift
//  dash-and-dine-mobile
//
//  Created by Matt Gordon on 3/5/17.
//  Copyright © 2017 Matt Gordon. All rights reserved.
//

import Foundation

class TrayItem {
    
    var meal: Meal
    var qty: Int
    
    init(meal: Meal, qty: Int) {
        
        self.meal = meal
        self.qty = qty
    }
}

class Tray {

    static let currentTray = Tray()
    
    var restaurant: Restaurant?
    var items = [TrayItem]()
    var address: String?
    
    func getTotal() -> Float {
        var total: Float = 0
        
        for item in self.items {
            total = total + Float(item.qty)
        }
        
        return total
    }
    
    func reset() {
        self.restaurant = nil
        self.items = []
        self.address = nil
    }
}