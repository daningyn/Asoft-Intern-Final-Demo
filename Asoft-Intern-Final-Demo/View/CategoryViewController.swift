//
//  CategoryViewController.swift
//  Asoft-Intern-Final-Demo
//
//  Created by Danh Nguyen on 1/3/17.
//  Copyright © 2017 Danh Nguyen. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController {

    //#MARK: - Outlet
    
    //#MARK: - Define properties
    var btnBarFilter = UIBarButtonItem()
    
    //#MARK: - Set up
    override func viewDidLoad() {
        super.viewDidLoad()
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        button.setImage(UIImage(named: AppResourceIdentifiers.kIdentifierIconFilter), for: .normal)
        button.addTarget(self, action: #selector(self.didTouchUpButtonFilter), for: .touchUpInside)
        btnBarFilter = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = btnBarFilter
        AppDelegate.shared.homeNavigation.navigationItem.hidesBackButton = true
        if let backButton = AppDelegate.shared.backBarButtonItem {
            self.navigationItem.leftBarButtonItem = backButton
        }
        self.navigationItem.title = AppNavigationTitle.kCategoryNavigationTitle
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //#MARK: - Define function bar button
    func didTouchUpButtonFilter() {
        
    }

}
