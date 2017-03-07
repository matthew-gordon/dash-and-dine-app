//
//  DriverOrderViewController.swift
//  dash-and-dine-mobile
//
//  Created by Matt Gordon on 3/6/17.
//  Copyright © 2017 Matt Gordon. All rights reserved.
//

import UIKit

class DriverOrderViewController: UITableViewController {
    
    @IBOutlet weak var menuBarButton: UIBarButtonItem!
    
    var orders = [DriverOrder]()
    let activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.revealViewController() != nil {
            menuBarButton.target = self.revealViewController()
            menuBarButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        loadReadyOrders()
    }

    func loadReadyOrders() {
        Helpers.showActivityIndicator(activityIndicator, self.view)
        
        APIManager.shared.getDriverOrders { (json) in
            
            print(json)
            if json != nil {
            
                self.orders = []
                if let readyOrders = json["orders"].array {
                
                    for item in readyOrders {
                        let order = DriverOrder(json: item)
                        self.orders.append(order)
                    }
                }
                
                self.tableView.reloadData()
                Helpers.hideActivityIndicator(self.activityIndicator)
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.orders.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DriverOrdersCell", for: indexPath) as! DriverOrderViewCell
        
        let order = orders[indexPath.row]
        cell.lbRestaurantName.text = order.restaurantName
        cell.lbCustomerName.text = order.customerName
        print(order.customerAddress)
        cell.lbCustomerAddress.text = order.customerAddress
        
        cell.imgCustomerAvatar.image = try! UIImage(data: Data(contentsOf: URL(string: order.customerAvatar!)!))
        cell.imgCustomerAvatar.layer.cornerRadius = 50/2
        cell.imgCustomerAvatar.clipsToBounds = true
        
        return cell
    }

}
