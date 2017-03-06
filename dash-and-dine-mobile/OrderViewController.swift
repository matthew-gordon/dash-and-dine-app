//
//  OrderViewController.swift
//  dash-and-dine-mobile
//
//  Created by Matt Gordon on 3/3/17.
//  Copyright © 2017 Matt Gordon. All rights reserved.
//

import UIKit
import SwiftyJSON

class OrderViewController: UIViewController {

    @IBOutlet weak var menuBarButton: UIBarButtonItem!
    @IBOutlet weak var tbvMeals: UITableView!
    
    var tray = [JSON]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.revealViewController() != nil {
            menuBarButton.target = self.revealViewController()
            menuBarButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        getLatestOrder()

    }
    
    func getLatestOrder() {
    
        APIManager.shared.getLatestOrder { (json) in
            
            print(json)
            
            if let orderDetails = json["order"]["order_details"].array {
                self.tray = orderDetails
                self.tbvMeals.reloadData()
            }
        }
    }

}

extension OrderViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderItemCell", for: indexPath) as! OrderViewCell
        
        let item = tray[indexPath.row]
        cell.lbQty.text = String(item["quantity"].int!)
        cell.lbMealName.text = item["meal"]["name"].string
        cell.lbSubTotal.text = "$\(String(item["sub_total"].float!))"
        
        return cell
    }
}
