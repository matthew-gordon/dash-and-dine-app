//
//  TrayViewController.swift
//  dash-and-dine-mobile
//
//  Created by Matt Gordon on 3/2/17.
//  Copyright © 2017 Matt Gordon. All rights reserved.
//

import UIKit
import MapKit

class TrayViewController: UIViewController {

    @IBOutlet weak var menuBarButton: UIBarButtonItem!
    @IBOutlet weak var tbvMeals: UITableView!
    @IBOutlet weak var viewTotal: UIView!
    @IBOutlet weak var viewAddress: UIView!
    @IBOutlet weak var viewMap: UIView!
    @IBOutlet weak var lbTotal: UILabel!
    @IBOutlet weak var textBoxAddress: UITextField!
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var bAddPayment: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if self.revealViewController() != nil {
            menuBarButton.target = self.revealViewController()
            menuBarButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        if Tray.currentTray.items.count == 0 {
            // Show message here
            
            let lbEmptyTray = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 40))
            lbEmptyTray.center = self.view.center
            lbEmptyTray.textAlignment = NSTextAlignment.center
            lbEmptyTray.text = "Your tray is currently empty. Please select a meal."
            
            self.view.addSubview(lbEmptyTray)
            
        } else {
        
            // Display all of the UI controls
            
            self.tbvMeals.isHidden = false
            self.viewTotal.isHidden = false
            self.viewAddress.isHidden = false
            self.viewMap.isHidden = false
            self.bAddPayment.isHidden = false
            
            loadMeals()
        }
    }
    
    func loadMeals() {
        self.tbvMeals.reloadData()
        self.lbTotal.text = "$\(Tray.currentTray.getTotal())"
        
    }
}

extension TrayViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrayItemCell", for: indexPath)
        
        return cell
    }
}
