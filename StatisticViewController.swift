//
//  StatisticViewController.swift
//  dash-and-dine-mobile
//
//  Created by Matt Gordon on 3/6/17.
//  Copyright © 2017 Matt Gordon. All rights reserved.
//

import UIKit

class StatisticViewController: UIViewController {

    @IBOutlet weak var menuBarButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if self.revealViewController() != nil {
            menuBarButton.target = self.revealViewController()
            menuBarButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
}
