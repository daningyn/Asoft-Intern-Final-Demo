//
//  SearchViewController.swift
//  Asoft-Intern-Final-Demo
//
//  Created by Danh Nguyen on 1/2/17.
//  Copyright © 2017 Danh Nguyen. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    //#MARK: - Set up
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AppDelegate.shared.homeNavigation.navigationItem.rightBarButtonItem = nil
        AppDelegate.shared.homeNavigation.navigationItem.hidesBackButton = true
        if let backButton = AppDelegate.shared.backBarButtonItem {
            self.navigationItem.leftBarButtonItem = backButton
        }
        self.navigationItem.title = AppNavigationTitle.kSearchNavigationTitle
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

}
