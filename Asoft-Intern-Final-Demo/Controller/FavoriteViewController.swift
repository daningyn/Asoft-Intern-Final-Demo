//
//  FavoriteViewController.swift
//  Asoft-Intern-Final-Demo
//
//  Created by Danh Nguyen on 1/5/17.
//  Copyright © 2017 Danh Nguyen. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        AppDelegate.shared.homeNavigation.navigationItem.rightBarButtonItem = nil
        AppDelegate.shared.homeNavigation.navigationItem.hidesBackButton = true
        if let backButton = AppDelegate.shared.backBarButtonItem {
            self.navigationItem.leftBarButtonItem = backButton
        }
        self.navigationItem.title = AppNavigationTitle.kFavoriteNavigationTitle
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
