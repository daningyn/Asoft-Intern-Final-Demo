//
//  SearchViewController.swift
//  Asoft-Intern-Final-Demo
//
//  Created by Danh Nguyen on 1/2/17.
//  Copyright © 2017 Danh Nguyen. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITextFieldDelegate {

    //#MARK: - Outlet
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var txtfldSearch: UITextField!
    
    //#MARK: - Define properties
    var didSearch = false
    
    //#MARK: - Set up
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AppDelegate.shared.homeNavigation.navigationItem.rightBarButtonItem = nil
        AppDelegate.shared.homeNavigation.navigationItem.hidesBackButton = true
        if let backButton = AppDelegate.shared.backBarButtonItem {
            self.navigationItem.leftBarButtonItem = backButton
        }
        self.navigationItem.title = AppNavigationTitle.kSearchNavigationTitle
        
        self.listTableView.dataSource = self
        self.listTableView.delegate = self
        
        self.txtfldSearch.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    
    //#MARK: - UITextField Delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            self.txtfldSearch.resignFirstResponder()
            self.didSearch = true
            self.listTableView.reloadData()
        } else {
            self.txtfldSearch.resignFirstResponder()
            self.didSearch = false
            self.listTableView.reloadData()
        }
        return true
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }

}


//#MARK: - UITableView DataSource
extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.didSearch {
            return 17
        } else {
            return 10
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.kIdentifierSearchTableViewCell, for: indexPath)
        
        cell.viewWithTag(1)?.clipsToBounds = true
        cell.viewWithTag(1)?.layer.cornerRadius = 4
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 0.3
        cell.layer.shadowOffset = CGSize.zero
        cell.layer.shadowRadius = 1
        if self.didSearch {
            (cell.viewWithTag(2) as! UIImageView).image = UIImage(named: AppResourceIdentifiers.kIdentifierDidSearchImageArray[indexPath.row % 3])
            (cell.viewWithTag(3) as! UILabel).text = AppResourceIdentifiers.kIdentifierDidSearchNameArray[indexPath.row % 3]
            (cell.viewWithTag(4) as! UILabel).text = AppResourceIdentifiers.kDidSearchTimeArray[indexPath.row % 3]
        } else {
            (cell.viewWithTag(2) as! UIImageView).image = UIImage(named: AppResourceIdentifiers.kIdentifierSearchImageArray[indexPath.row % 5])
            (cell.viewWithTag(3) as! UILabel).text = AppResourceIdentifiers.kIdentifierSearchNameArray[indexPath.row % 5]
            (cell.viewWithTag(4) as! UILabel).text = AppResourceIdentifiers.kSearchTimeArray[indexPath.row % 5]
        }
        
        return cell
    }
    
}


//#MARK: - UITableView Delegate
extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.height/2.5
    }
    
}












